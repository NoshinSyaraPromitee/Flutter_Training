import 'dart:typed_data';

class Diagnosis {
  const Diagnosis({
    required this.issue,
    required this.cure,
    required this.disclaimer,
    this.provider,
  });
  final String issue, cure, disclaimer;
  final String? provider;
}

/// One AI reply.
class BotReply {
  const BotReply({
    required this.text,
    this.plantName,
    this.diagnosis,
    this.suggestedChips = const [],
    this.provider,
  });
  final String text;
  final String? plantName;
  final Diagnosis? diagnosis;
  final List<String> suggestedChips;
  final String? provider;
}

class ChatMessage {
  ChatMessage({
    required this.fromUser,
    required this.text,
    this.imageBytes,
    this.diagnosis,
    this.suggestedChips = const [],
    this.provider,
  }) : id = DateTime.now().microsecondsSinceEpoch.toString();

  factory ChatMessage.user(String text, {Uint8List? imageBytes}) =>
      ChatMessage(fromUser: true, text: text, imageBytes: imageBytes);
  factory ChatMessage.bot(BotReply r) => ChatMessage(
    fromUser: false,
    text: r.text,
    diagnosis: r.diagnosis,
    suggestedChips: r.suggestedChips,
    provider: r.provider ?? r.diagnosis?.provider,
  );

  final String id;
  final bool fromUser;
  final String text;
  final Uint8List? imageBytes;
  final Diagnosis? diagnosis;
  final List<String> suggestedChips;
  final String? provider;
}
