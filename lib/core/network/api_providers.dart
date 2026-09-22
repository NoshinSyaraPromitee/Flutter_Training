import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/locale_provider.dart';
import 'api_client.dart';

part 'api_providers.g.dart';

/// Rebuilds whenever the app's language changes, so every repository
/// downstream picks up a client that sends the current Accept-Language.
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final locale = ref.watch(appLocaleProvider);
  return ApiClient(languageCode: locale.languageCode);
}
