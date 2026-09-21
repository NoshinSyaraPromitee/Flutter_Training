import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../domain/entities/diagnosis.dart';
import '../../domain/failures/diagnosis_failure.dart';
import '../../domain/repositories/diagnosis_repository.dart';
import '../models/diagnosis_dto.dart';

/// Talks to the Go backend's diagnosis endpoints.
///
/// Replaces `FakeDiagnosisRepository`, which can now be deleted. The AI is
/// still a mock — but it's a mock *on the backend*
/// (`internal/infrastructure/ai/mock_diagnosis_provider.go`), which is the
/// right place for it. Flutter never calls Gemini/Groq directly; swapping
/// that mock for the real provider is a backend-only change and this file
/// won't need to move.
class ApiDiagnosisRepository implements DiagnosisRepository {
  ApiDiagnosisRepository(this._dio);

  final Dio _dio;

  /// Matches the route registered in `internal/interface/http/v1/router.go`.
  static const String _diagnosesPath = '/api/v1/diagnoses';

  @override
  Future<Diagnosis> diagnosePlant({
    required Uint8List imageBytes,
    String? plantId,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        _diagnosesPath,
        data: <String, dynamic>{
          // The handler decodes with base64.StdEncoding and no data-URI
          // prefix, which is exactly what base64Encode produces. Adding a
          // "data:image/png;base64," prefix here would produce a 400.
          'imageBase64': base64Encode(imageBytes),
          if (plantId != null) 'plantId': plantId,
        },
      );

      final body = response.data;
      if (body is! Map) {
        throw const DiagnosisFailure(
          'The server sent an unexpected response.',
          kind: DiagnosisFailureKind.server,
        );
      }

      final data = body['data'];
      if (data is! Map<String, dynamic>) {
        throw const DiagnosisFailure(
          'The server response was missing the diagnosis.',
          kind: DiagnosisFailureKind.server,
        );
      }

      return DiagnosisDto.fromJson(data).toEntity();
    } on DioException catch (e) {
      throw _asFailure(e);
    }
  }

  /// Translates Dio's transport errors into something showable.
  DiagnosisFailure _asFailure(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
        return DiagnosisFailure(
          "Couldn't reach the MyPlantPal server at ${_dio.options.baseUrl}. "
          'Make sure the Go backend is running.',
          kind: DiagnosisFailureKind.network,
        );

      case DioExceptionType.sendTimeout:
        return const DiagnosisFailure(
          'Uploading the photo took too long. Try again on a better '
          'connection, or with a smaller photo.',
          kind: DiagnosisFailureKind.network,
        );

      case DioExceptionType.receiveTimeout:
        return const DiagnosisFailure(
          'The analysis took too long to come back. Please try again.',
          kind: DiagnosisFailureKind.network,
        );

      case DioExceptionType.badResponse:
        final status = e.response?.statusCode ?? 0;
        // Errors come back as {"error": "invalid input: ..."} — prefer the
        // backend's own wording over a guess.
        final serverMessage = _extractError(e.response?.data);

        if (status == 400) {
          return DiagnosisFailure(
            serverMessage ?? "The server couldn't read that photo.",
            kind: DiagnosisFailureKind.invalidRequest,
          );
        }
        return DiagnosisFailure(
          serverMessage ?? 'The server had a problem (HTTP $status).',
          kind: DiagnosisFailureKind.server,
        );

      case DioExceptionType.cancel:
        return const DiagnosisFailure(
          'The analysis was cancelled.',
          kind: DiagnosisFailureKind.unknown,
        );

      // Dio 5.11 added `transformTimeout`, which an exhaustive switch
      // refused to compile against. Handled explicitly because it is a
      // timeout the user can act on, not a mystery failure.
      case DioExceptionType.transformTimeout:
        return const DiagnosisFailure(
          'The analysis came back but took too long to process. '
          'Please try again.',
          kind: DiagnosisFailureKind.network,
        );

      // `default` rather than listing badCertificate/unknown: an
      // exhaustive switch here means any future Dio release that adds
      // another type breaks the build, which is exactly what happened
      // on the 5.11 upgrade. Every unlisted type is a failure we have
      // no specific advice for anyway, so they share one message.
      default:
        return const DiagnosisFailure(
          'Something went wrong talking to the server.',
          kind: DiagnosisFailureKind.unknown,
        );
    }
  }

  String? _extractError(dynamic data) {
    if (data is Map) {
      final message = data['error'];
      if (message is String && message.isNotEmpty) return message;
    }
    return null;
  }
}
