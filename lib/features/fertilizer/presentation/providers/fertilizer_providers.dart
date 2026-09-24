import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:plantpal/features/fertilizer/data/repositories/fertilizer_local_repository.dart";
import "package:plantpal/features/fertilizer/domain/model/fertilizer.dart";
import "package:plantpal/features/fertilizer/domain/repositories/fertilizer_repository.dart";

part "fertilizer_providers.g.dart";

/// Fertilizer data source. Bundled locally today; swap the
/// implementation for a REST-backed repository without touching the UI.
@Riverpod(keepAlive: true)
FertilizerRepository fertilizerRepository(Ref ref) => FertilizerLocalRepository();

/// The full recipe catalog (bundled recipes + anything added this session).
@Riverpod(keepAlive: true)
class FertilizerRecipes extends _$FertilizerRecipes {
  @override
  Future<FertilizerCatalog> build() => ref.watch(fertilizerRepositoryProvider).getCatalog();

  /// Adds a user-created recipe to the in-memory catalog.
  Future<void> addRecipe(Fertilizer recipe) async {
    final current = await future;
    state = AsyncData(
      FertilizerCatalog(items: [...current.items, recipe], safetyTips: current.safetyTips),
    );
  }
}

/// Current search text for the fertilizer list.
@riverpod
class FertilizerQuery extends _$FertilizerQuery {
  @override
  String build() => "";
  void set(String q) => state = q;
}

/// Recipes matching the current search query.
@riverpod
List<Fertilizer> filteredFertilizers(Ref ref) {
  final query = ref.watch(fertilizerQueryProvider);
  final catalog = ref.watch(fertilizerRecipesProvider).value;
  if (catalog == null) return const [];
  return catalog.items.where((f) => f.matches(query)).toList();
}

/// A single recipe by id, or null if not found / not loaded yet.
@riverpod
Fertilizer? fertilizerById(Ref ref, String id) {
  final catalog = ref.watch(fertilizerRecipesProvider).value;
  if (catalog == null) return null;
  for (final f in catalog.items) {
    if (f.id == id) return f;
  }
  return null;
}

