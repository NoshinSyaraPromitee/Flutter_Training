import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

/// The message composer at the bottom of the AI Chat screen.
class ChatInput extends StatefulWidget {
  const ChatInput({super.key, required this.onSend, this.isSending = false});

  final ValueChanged<String> onSend;
  final bool isSending;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.isSending) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _submit(),
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: 'What would you like to know?',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Material(
            color: AppColors.teal,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: widget.isSending ? null : _submit,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: widget.isSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: 20,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
