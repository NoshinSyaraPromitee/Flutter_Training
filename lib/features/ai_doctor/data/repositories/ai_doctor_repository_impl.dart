import 'package:plantpal/core/network/failure.dart';
import 'package:plantpal/features/ai_doctor/data/datasources/ai_doctor_remote_data_source.dart';
import 'package:plantpal/features/ai_doctor/domain/model/chat_models.dart';
import 'package:plantpal/features/ai_doctor/domain/repositories/ai_doctor_repository.dart';

class AiDoctorRepositoryImpl implements AiDoctorRepository {
  AiDoctorRepositoryImpl(this._remote);
  final AiDoctorRemoteDataSource _remote;

  List<String> _strings(dynamic v) => (v as List?)?.map((e) => e.toString()).toList() ?? const [];

  BotReply _reply(Map<String, dynamic> j) {
    final d = j['diagnosis'];
    return BotReply(
      text: j['text']?.toString() ?? '',
      plantName: j['plantName']?.toString(),
      suggestedChips: _strings(j['suggestedChips']),
      diagnosis: d is Map<String, dynamic>
          ? Diagnosis(
              issue: d['issue']?.toString() ?? 'Unknown',
              confidence: d['confidence']?.toString() ?? '—',
              severity: d['severity']?.toString() ?? '—',
              treatment: d['treatment']?.toString() ?? '',
              fertilizer: d['fertilizer']?.toString() ?? '',
              shopItems: _strings(d['shopItems']),
            )
          : null,
    );
  }

  @override
  Future<BotReply> chat(String text) => guardCall(() async => _reply(await _remote.chat(text)));

  @override
  Future<BotReply> analyzeImage(String imagePath, {String? caption}) =>
      guardCall(() async => _reply(await _remote.diagnose(imagePath, caption)));
}