import 'package:plantpal/features/ai_doctor/domain/entities/chat_models.dart';

abstract class AiDoctorRepository {
  Future<BotReply> chat(String text);
  Future<BotReply> analyzeImage(String imagePath, {String? caption});
}