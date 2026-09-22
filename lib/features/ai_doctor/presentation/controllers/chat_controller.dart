import 'package:flutter/foundation.dart';
import 'package:plantpal/core/network/failure.dart';
import 'package:plantpal/features/ai_doctor/domain/entities/chat_models.dart';
import 'package:plantpal/features/ai_doctor/domain/repositories/ai_doctor_repository.dart';

class ChatController extends ChangeNotifier {
  ChatController(this._repo);
  final AiDoctorRepository _repo;

  /// Newest first (the list view is reversed).
  final List<ChatMessage> messages = [
    ChatMessage(
      fromUser: false,
      text: "Hello! I'm PlantBot.\nHow can I help your plants today?",
      suggestedChips: const ['Why are my leaves yellow?', 'Homemade Banana Fertilizer', 'Treat Leaf Spot'],
    ),
  ];
  bool typing = false;

  String _friendly(Failure f) {
    if (f.statusCode == 429) return 'Free-tier rate limit reached. Please wait 10 seconds and try again.';
    if (f.isUnauthorized) return 'Please sign in with Google to chat with PlantBot.';
    if (f.statusCode == null) return 'I am having trouble connecting to my plant knowledge base. Please check your connection.';
    return 'I had trouble with that request. Please try again!';
  }

  Future<void> send(String text, {String? imagePath}) async {
    final t = text.trim();
    if ((t.isEmpty && imagePath == null) || typing) return;
    messages.insert(0, ChatMessage.user(t.isEmpty ? '📷 Photo sent' : t, imagePath: imagePath));
    typing = true;
    notifyListeners();
    try {
      final reply = imagePath != null ? await _repo.analyzeImage(imagePath, caption: t) : await _repo.chat(t);
      messages.insert(0, ChatMessage.bot(reply));
    } catch (e) {
      messages.insert(0, ChatMessage(fromUser: false, text: _friendly(Failure.from(e))));
    }
    typing = false;
    notifyListeners();
  }
}