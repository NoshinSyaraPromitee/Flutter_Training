import 'package:dio/dio.dart';
import 'package:plantpal/core/network/api_client.dart';

class AiDoctorRemoteDataSource {
  AiDoctorRemoteDataSource(this._api);
  final ApiClient _api;

  Future<Map<String, dynamic>> chat(String text) async =>
      (await _api.dio.post('/ai/chat', data: {'text': text})).data as Map<String, dynamic>;

  Future<Map<String, dynamic>> diagnose(String imagePath, String? caption) async {
    final form = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath),
      if (caption != null && caption.isNotEmpty) 'caption': caption,
    });
    return (await _api.dio.post('/ai/diagnose', data: form)).data as Map<String, dynamic>;
  }
}