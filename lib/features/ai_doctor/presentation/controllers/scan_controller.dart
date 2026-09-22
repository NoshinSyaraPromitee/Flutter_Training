import 'package:flutter/foundation.dart';
import 'package:plantpal/core/network/failure.dart';
import 'package:plantpal/features/ai_doctor/domain/model/chat_models.dart';
import 'package:plantpal/features/ai_doctor/domain/repositories/ai_doctor_repository.dart';

class ScanController extends ChangeNotifier {
  ScanController(this._repo);
  final AiDoctorRepository _repo;

  bool loading = false;
  String? error;
  String? imagePath;
  BotReply? result;

  Future<bool> analyze(String path) async {
    loading = true;
    error = null;
    imagePath = path;
    notifyListeners();
    try {
      result = await _repo.analyzeImage(path);
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      final f = Failure.from(e);
      error = f.statusCode == 429
          ? 'Rate limit reached. Please wait 10 seconds and try again.'
          : f.isUnauthorized
              ? 'Please sign in with Google to scan plants.'
              : "I couldn't analyze that photo. Please try again.";
      result = null;
      loading = false;
      notifyListeners();
      return false;
    }
  }
}