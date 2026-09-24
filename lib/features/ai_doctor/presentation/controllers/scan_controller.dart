import 'package:flutter/foundation.dart';
import '../../../../core/network/failure.dart';
import '../../domain/entities/chat_models.dart';
import '../../domain/repositories/ai_doctor_repository.dart';

class ScanController extends ChangeNotifier {
  ScanController(this._repo);
  final AiDoctorRepository _repo;

  bool loading = false;
  String? error;
  Uint8List? imageBytes;
  BotReply? result;

  Future<bool> analyze(Uint8List bytes) async {
    loading = true;
    error = null;
    imageBytes = bytes;
    notifyListeners();
    try {
      result = await _repo.analyzeImage(bytes);
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
