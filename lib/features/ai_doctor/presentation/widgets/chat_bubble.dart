import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/chat_message.dart';

/// A single chat message bubble, aligned/colored by [ChatMessage.role].
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.teal : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppRadius.sm),
            topRight: const Radius.circular(AppRadius.sm),
            bottomLeft: Radius.circular(isUser ? AppRadius.sm : 2),
            bottomRight: Radius.circular(isUser ? 2 : AppRadius.sm),
          ),
        ),
        child: Text(
          message.content,
          style: AppTextStyles.bodyText.copyWith(
            color: isUser ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
