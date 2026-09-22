enum ChatRole { user, assistant }

ChatRole _roleFromJson(String value) =>
    value == 'assistant' ? ChatRole.assistant : ChatRole.user;

/// A single turn in an AI Chat session, backed by /api/v1/chat/messages.
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.content,
  });

  final String id;
  final String sessionId;
  final ChatRole role;
  final String content;

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      role: _roleFromJson(json['role'] as String),
      content: json['content'] as String,
    );
  }
}
