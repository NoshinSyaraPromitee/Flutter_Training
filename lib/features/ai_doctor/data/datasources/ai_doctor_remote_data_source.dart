import 'dart:io';

import 'package:plantpal/core/network/api_client.dart';

class AiDoctorRemoteDataSource {
  AiDoctorRemoteDataSource(this._api);
  final ApiClient _api;

  Future<Map<String, dynamic>> chat(String text) async =>
      (await _api.dio.post('/ai/chat', data: {'text': text})).data
          as Map<String, dynamic>;

  Future<Map<String, dynamic>> diagnose(
    String imagePath,
    String? caption,
  ) async {
    final data = {
      'image': await File(imagePath).readAsBytes(),
      if (caption != null && caption.isNotEmpty) 'caption': caption,
    };
    return (await _api.dio.post('/ai/diagnose', data: data)).data
        as Map<String, dynamic>;
  }
}
