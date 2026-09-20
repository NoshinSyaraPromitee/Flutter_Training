import 'fertilizer.dart';

/// Repository contract for the Fertilizer feature. The API-backed
/// implementation lives in data/fertilizer_api_repository.dart.
abstract class FertilizerRepository {
  /// Returns fertilizers whose name/category match [query]. An empty query
  /// returns every fertilizer.
  Future<List<Fertilizer>> search(String query);

  Future<Fertilizer> create({
    required String name,
    required String category,
    required String instructions,
  });
}
