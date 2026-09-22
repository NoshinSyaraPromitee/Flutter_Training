import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_providers.dart';
import '../../domain/fertilizer.dart';
import '../../repository/fertilizer_api_repository.dart';
import '../../repository/fertilizer_repository.dart';

part 'fertilizer_providers.g.dart';

@Riverpod(keepAlive: true)
FertilizerRepository fertilizerRepository(Ref ref) {
  return FertilizerApiRepository(ref.watch(apiClientProvider));
}

/// The current text in the fertilizer search bar.
@Riverpod(keepAlive: true)
class FertilizerSearchQuery extends _$FertilizerSearchQuery {
  @override
  String build() => '';

  void set(String value) => state = value;
}

/// Fetches fertilizers matching [fertilizerSearchQueryProvider]. Re-runs
/// automatically whenever the query changes.
@riverpod
Future<List<Fertilizer>> fertilizerList(Ref ref) {
  final query = ref.watch(fertilizerSearchQueryProvider);
  final repo = ref.watch(fertilizerRepositoryProvider);
  return repo.search(query);
}
