import 'dart:convert';
import 'dart:typed_data';

import '../../../core/network/api_client.dart';
import '../domain/diagnosis.dart';
import 'diagnosis_repository.dart';

class DiagnosisApiRepository implements DiagnosisRepository {
  DiagnosisApiRepository(this._client);

  final ApiClient _client;

  @override
  Future<Diagnosis> analyze(Uint8List imageBytes) async {
    final data = await _client.post(
      '/api/v1/diagnoses',
      body: {'imageBase64': base64Encode(imageBytes)},
    );
    return Diagnosis.fromJson(data as Map<String, dynamic>);
  }
}
