import 'dart:typed_data';

import '../entities/chat_models.dart';

abstract class AiDoctorRepository {
  Future<BotReply> chat(String sessionId, String text);
  Future<BotReply> analyzeImage(Uint8List imageBytes, {String? plantId});
}
