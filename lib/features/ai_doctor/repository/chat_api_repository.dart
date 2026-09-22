import '../../../core/network/api_client.dart';
import '../domain/chat_message.dart';
import 'chat_repository.dart';

class ChatApiRepository implements ChatRepository {
  ChatApiRepository(this._client);

  final ApiClient _client;

  @override
  Future<List<ChatMessage>> send({
    required String sessionId,
    required String content,
  }) async {
    final data = await _client.post(
      '/api/v1/chat/messages',
      body: {'sessionId': sessionId, 'content': content},
    );
    return (data as List)
        .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ChatMessage>> history(String sessionId) async {
    final data = await _client.get(
      '/api/v1/chat/messages',
      query: {'sessionId': sessionId},
    );
    return (data as List)
        .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
