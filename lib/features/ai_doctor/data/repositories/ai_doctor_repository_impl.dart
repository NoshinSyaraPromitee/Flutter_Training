import 'dart:typed_data';

import '../../../../core/network/failure.dart';
import '../datasources/ai_doctor_remote_data_source.dart';
import '../../domain/entities/chat_models.dart';
import '../../domain/repositories/ai_doctor_repository.dart';

class AiDoctorRepositoryImpl implements AiDoctorRepository {
  AiDoctorRepositoryImpl(this._remote);
  final AiDoctorRemoteDataSource _remote;

  BotReply _chatReply(Map<String, dynamic> j) => BotReply(
    text: j['content']?.toString() ?? '',
    provider: j['provider']?.toString(),
  );

  BotReply _diagnosisReply(Map<String, dynamic> j) => BotReply(
    text: '',
    diagnosis: Diagnosis(
      issue: j['issue']?.toString() ?? 'Unknown',
      cure: j['cure']?.toString() ?? '',
      disclaimer: j['disclaimer']?.toString() ?? '',
      provider: j['provider']?.toString(),
    ),
  );

  @override
  Future<BotReply> chat(String sessionId, String text) =>
      guardCall(() async => _chatReply(await _remote.chat(sessionId, text)));

  @override
  Future<BotReply> analyzeImage(Uint8List imageBytes, {String? plantId}) =>
      guardCall(
        () async => _diagnosisReply(
          await _remote.diagnose(imageBytes, plantId: plantId),
        ),
      );
}
