import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/secure_storage.dart';
import 'api_client.dart';

part 'api_providers.g.dart';

/// Provides the shared API client used by repositories.
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient(const SecureStorage());
}
