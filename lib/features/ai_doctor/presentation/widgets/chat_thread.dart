import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/model/chat_models.dart';
import 'chat_bubble.dart';

/// The scrollable message list area: loading / empty / populated states.
class ChatThread extends StatelessWidget {
  const ChatThread({
    super.key,
    required this.isLoading,
    required this.messages,
    required this.scrollController,
    this.onChip,
  });

  final bool isLoading;
  final List<ChatMessage>? messages;
  final ScrollController scrollController;
  final ValueChanged<String>? onChip;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const LoadingView();

    if (messages == null || messages!.isEmpty) {
      return const EmptyView(
        icon: Icons.chat_bubble_outline,
        title: 'No messages yet',
        subtitle: 'Ask our expert anything about caring for your plants.',
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      itemCount: messages!.length,
      itemBuilder: (context, index) => ChatBubble(
        message: messages![index],
        onChip: onChip ?? (_) {},
      ),
    );
  }
}