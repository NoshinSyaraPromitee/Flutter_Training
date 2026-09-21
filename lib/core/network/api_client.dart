import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_config.dart';
import 'api_exception.dart';

/// Thin REST client shared by every feature's data layer. Unwraps the
/// backend's `{"data": ...}` / `{"error": ...}` JSON envelope and throws
/// [ApiException] for non-2xx responses.
class ApiClient {
  ApiClient({http.Client? client, String? baseUrl, this.languageCode = 'en'})
    : _client = client ?? http.Client(),
      baseUrl = baseUrl ?? ApiConfig.baseUrl;

  final http.Client _client;
  final String baseUrl;
  final String languageCode;

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    // Lets the backend return localized text (fertilizer recipes,
    // diagnosis results, care tips) for seeded/generated content.
    'Accept-Language': languageCode,
  };

  Future<dynamic> get(String path, {Map<String, String>? query}) async {
    var uri = Uri.parse('$baseUrl$path');
    if (query != null && query.isNotEmpty) {
      uri = uri.replace(queryParameters: query);
    }
    final response = await _client.get(uri, headers: _headers);
    return _decode(response);
  }

  Future<dynamic> post(String path, {Object? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    final response = await _client.post(
      uri,
      headers: _headers,
      body: body == null ? null : jsonEncode(body),
    );
    return _decode(response);
  }

  dynamic _decode(http.Response response) {
    final decoded = response.body.isEmpty ? null : jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded is Map<String, dynamic> ? decoded['data'] : decoded;
    }

    final message =
        (decoded is Map<String, dynamic> ? decoded['error'] as String? : null) ??
        'Request failed with status ${response.statusCode}';
    throw ApiException(response.statusCode, message);
  }
}
