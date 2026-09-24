import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_screen.dart';
import '../controllers/chat_controller.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final chat = context.watch<ChatController>();
    return AppScreen(
      title: l10n.aiDoctorMenuLabel,
      showBack: false,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: chat.messages.length,
              itemBuilder: (_, i) => ChatBubble(
                message: chat.messages[i],
                onChip: (t) => context.read<ChatController>().send(t),
              ),
            ),
          ),
          if (chat.typing)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.greenPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.plantBotAnalyzingLabel,
                    style: AppTextStyles.inter(13, c: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ChatInput(
            onSend: (text, imageBytes) => context.read<ChatController>().send(
              text,
              imageBytes: imageBytes,
            ),
          ),
        ],
      ),
    );
  }
}
