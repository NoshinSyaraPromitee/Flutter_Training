import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/locale_provider.dart';
import 'api_client.dart';

/// Rebuilds whenever the app's language changes, so every repository
/// downstream picks up a client that sends the current Accept-Language.
final apiClientProvider = Provider<ApiClient>((ref) {
  final locale = ref.watch(localeProvider);
  return ApiClient(languageCode: locale.languageCode);
});
