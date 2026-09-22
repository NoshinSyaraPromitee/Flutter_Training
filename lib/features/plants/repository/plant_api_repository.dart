import '../../../core/network/api_client.dart';
import '../domain/plant.dart';
import 'plant_repository.dart';

class PlantApiRepository implements PlantRepository {
  PlantApiRepository(this._client);

  final ApiClient _client;

  @override
  Future<Plant> create({
    required String name,
    required String type,
    required String ageStage,
  }) async {
    final data = await _client.post(
      '/api/v1/plants',
      body: {'name': name, 'type': type, 'ageStage': ageStage},
    );
    return Plant.fromJson(data as Map<String, dynamic>);
  }
}
