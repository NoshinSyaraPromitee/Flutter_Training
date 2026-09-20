import '../../../core/network/api_client.dart';
import '../domain/fertilizer.dart';
import '../domain/fertilizer_repository.dart';

class FertilizerApiRepository implements FertilizerRepository {
  FertilizerApiRepository(this._client);

  final ApiClient _client;

  @override
  Future<List<Fertilizer>> search(String query) async {
    final data = await _client.get(
      '/api/v1/fertilizers',
      query: query.isEmpty ? null : {'q': query},
    );
    return (data as List)
        .map((e) => Fertilizer.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Fertilizer> create({
    required String name,
    required String category,
    required String instructions,
  }) async {
    final data = await _client.post(
      '/api/v1/fertilizers',
      body: {'name': name, 'category': category, 'instructions': instructions},
    );
    return Fertilizer.fromJson(data as Map<String, dynamic>);
  }
}
