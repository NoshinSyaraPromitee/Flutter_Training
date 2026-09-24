import 'dart:convert';
import 'dart:typed_data';

import '../../../../core/network/api_client.dart';

class AiDoctorRemoteDataSource {
  AiDoctorRemoteDataSource(this._api);
  final ApiClient _api;

  /// Posts a chat message and returns the assistant's [Message] (the backend
  /// replies with both the user and assistant turns; we only need the latter).
  Future<Map<String, dynamic>> chat(String sessionId, String text) async {
    final res = await _api.dio.post(
      '/api/v1/chat/messages',
      data: {'sessionId': sessionId, 'content': text},
    );
    final messages = (res.data as List).cast<Map<String, dynamic>>();
    return messages.firstWhere(
      (m) => m['role'] == 'assistant',
      orElse: () => messages.last,
    );
  }

  /// Submits a plant photo for diagnosis. The backend takes the image as
  /// base64 JSON, not multipart.
  Future<Map<String, dynamic>> diagnose(
    Uint8List imageBytes, {
    String? plantId,
  }) async {
    final res = await _api.dio.post(
      '/api/v1/diagnoses',
      data: {'plantId': plantId, 'imageBase64': base64Encode(imageBytes)},
    );
    return res.data as Map<String, dynamic>;
  }
}
