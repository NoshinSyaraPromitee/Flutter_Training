class Diagnosis {
  const Diagnosis({
    required this.issue,
    required this.confidence,
    required this.severity,
    required this.treatment,
    required this.fertilizer,
    this.shopItems = const [],
  });
  final String issue, confidence, severity, treatment, fertilizer;
  final List<String> shopItems;
}

/// One AI reply.
class BotReply {
  const BotReply({required this.text, this.plantName, this.diagnosis, this.suggestedChips = const []});
  final String text;
  final String? plantName;
  final Diagnosis? diagnosis;
  final List<String> suggestedChips;
}

class ChatMessage {
  ChatMessage({required this.fromUser, required this.text, this.imagePath, this.diagnosis, this.suggestedChips = const []})
      : id = DateTime.now().microsecondsSinceEpoch.toString();

  factory ChatMessage.user(String text, {String? imagePath}) => ChatMessage(fromUser: true, text: text, imagePath: imagePath);
  factory ChatMessage.bot(BotReply r) =>
      ChatMessage(fromUser: false, text: r.text, diagnosis: r.diagnosis, suggestedChips: r.suggestedChips);

  final String id;
  final bool fromUser;
  final String text;
  final String? imagePath;
  final Diagnosis? diagnosis;
  final List<String> suggestedChips;
}