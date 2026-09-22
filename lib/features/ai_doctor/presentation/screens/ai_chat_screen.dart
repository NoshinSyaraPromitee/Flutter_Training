import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../domain/chat_message.dart';
import '../providers/chat_providers.dart';
import '../widgets/chat_error_banner.dart';
import '../widgets/chat_input.dart';
import '../widgets/chat_thread.dart';

/// A stable session id for the lifetime of the app process — the backend
/// keys chat history by session id, and there's no auth/user id to key on
/// instead yet.
final chatSessionIdProvider = Provider<String>(
  (ref) => DateTime.now().millisecondsSinceEpoch.toString(),
);

/// "Chat with expert" screen (bottom tab, route `/ai-doctor`), wired to
/// the real /api/v1/chat/messages backend.
class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _scrollController = ScrollController();
  List<ChatMessage>? _messages;
  bool _isLoadingHistory = true;
  bool _isSending = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    try {
      final sessionId = ref.read(chatSessionIdProvider);
      final history = await ref.read(chatRepositoryProvider).history(sessionId);
      if (!mounted) return;
      setState(() {
        _messages = history;
        _isLoadingHistory = false;
      });
    } catch (_) {
      if (!mounted) return;
      // No history yet (or a transient error) — start with an empty thread
      // rather than blocking the composer.
      setState(() {
        _messages = [];
        _isLoadingHistory = false;
      });
    }
  }

  Future<void> _send(String content) async {
    setState(() {
      _isSending = true;
      _errorMessage = null;
    });
    try {
      final sessionId = ref.read(chatSessionIdProvider);
      final newMessages = await ref
          .read(chatRepositoryProvider)
          .send(sessionId: sessionId, content: content);
      if (!mounted) return;
      setState(() => _messages = [...?_messages, ...newMessages]);
      _scrollToEnd();
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
    } catch (_) {
      if (!mounted) return;
      setState(
        () => _errorMessage =
            'Could not reach the server. Is the backend running?',
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'Chat with\nExpert',
            subtitle: 'Ask a quick question about your plants.',
            color: AppColors.teal,
            corner: const LanguageSwitcher(),
          ),
          if (_errorMessage != null) ChatErrorBanner(message: _errorMessage!),
          Expanded(
            child: ChatThread(
              isLoading: _isLoadingHistory,
              messages: _messages,
              scrollController: _scrollController,
            ),
          ),
          ChatInput(onSend: _send, isSending: _isSending),
        ],
      ),
    );
  }
}
