import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_providers.dart';
import '../../repository/chat_api_repository.dart';
import '../../repository/chat_repository.dart';

part 'chat_providers.g.dart';

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) {
  return ChatApiRepository(ref.watch(apiClientProvider));
}
