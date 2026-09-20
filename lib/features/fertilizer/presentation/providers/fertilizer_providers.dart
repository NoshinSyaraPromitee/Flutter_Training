import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_providers.dart';
import '../../data/fertilizer_api_repository.dart';
import '../../domain/fertilizer.dart';
import '../../domain/fertilizer_repository.dart';

final fertilizerRepositoryProvider = Provider<FertilizerRepository>((ref) {
  return FertilizerApiRepository(ref.watch(apiClientProvider));
});

/// The current text in the fertilizer search bar.
final fertilizerSearchQueryProvider = StateProvider<String>((ref) => '');

/// Fetches fertilizers matching [fertilizerSearchQueryProvider]. Re-runs
/// automatically whenever the query changes.
final fertilizerListProvider = FutureProvider.autoDispose<List<Fertilizer>>((
  ref,
) {
  final query = ref.watch(fertilizerSearchQueryProvider);
  final repo = ref.watch(fertilizerRepositoryProvider);
  return repo.search(query);
});
