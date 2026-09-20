/// Thrown when the backend returns a non-2xx response. [message] is the
/// `error` field from the API's JSON error envelope when present.
class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}
