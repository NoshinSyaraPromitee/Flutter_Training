import '../domain/chat_message.dart';

/// Talks to the "Chat with expert" backend (POST/GET /api/v1/chat/messages).
abstract class ChatRepository {
  /// Sends [content] in [sessionId] and returns the new messages (the
  /// user's message and the generated assistant reply, in that order).
  Future<List<ChatMessage>> send({
    required String sessionId,
    required String content,
  });

  /// Returns the full message history for [sessionId].
  Future<List<ChatMessage>> history(String sessionId);
}
