import 'dart:convert';

/// Decodes the payload only. The signature was already verified by the server.
Map<String, dynamic> decodeJwtPayload(String jwt) {
  final part = jwt.split('.')[1];
  return jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(part)))) as Map<String, dynamic>;
}