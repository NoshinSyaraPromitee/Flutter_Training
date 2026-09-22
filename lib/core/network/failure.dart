import 'package:dio/dio.dart';

class Failure implements Exception {
  const Failure(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  bool get isUnauthorized => statusCode == 401;

  factory Failure.from(Object e) {
    if (e is Failure) return e;
    if (e is DioException) {
      final code = e.response?.statusCode;
      final data = e.response?.data;
      final server = data is Map ? data['error']?.toString() : null;
      if (code == null) return const Failure("Can't reach the server. Check your connection and try again.");
      return Failure(server ?? 'Something went wrong (HTTP $code).', statusCode: code);
    }
    return Failure(e.toString());
  }

  @override
  String toString() => message;
}

/// Wraps a repository call so callers only ever see [Failure].
Future<T> guardCall<T>(Future<T> Function() run) async {
  try {
    return await run();
  } catch (e) {
    throw Failure.from(e);
  }
}