import 'package:plantpal/core/cache/cache_manager.dart';
import 'package:plantpal/core/network/failure.dart';
import 'package:plantpal/features/plants/data/datasources/plant_remote_data_source.dart';
import 'package:plantpal/features/plants/data/models/plant_dto.dart';
import 'package:plantpal/features/plants/domain/model/plant.dart';
import 'package:plantpal/features/plants/domain/repositories/plant_repository.dart';

class PlantRepositoryImpl implements PlantRepository {
  PlantRepositoryImpl(this._remote);
  final PlantRemoteDataSource _remote;
  static const _cacheKey = 'plants_list';

  @override
  Future<List<Plant>> getPlants({bool forceRefresh = false}) => guardCall(() async {
        if (!forceRefresh) {
          final cached = await CacheManager.instance.read<List<Plant>>(
            _cacheKey,
            (json) => (json as List)
                .map((e) => PlantDto.fromJson(e as Map<String, dynamic>).toEntity())
                .toList(),
          );
          if (cached != null) return cached;
        }
        final fresh = (await _remote.fetchAll()).map((j) => PlantDto.fromJson(j).toEntity()).toList();
        await CacheManager.instance.write(
          _cacheKey,
          fresh.map((p) => PlantDto.fromEntity(p).toJson()).toList(),
        );
        return fresh;
      });

  @override
  Future<Plant> addPlant(NewPlant plant) => guardCall(() async {
        final created = PlantDto.fromJson(await _remote.create(PlantDto.newPlantToJson(plant))).toEntity();
        await CacheManager.instance.invalidate(_cacheKey);
        return created;
      });

  @override
  Future<Plant> updatePlant(String id, Map<String, dynamic> changes) => guardCall(() async {
        final updated = PlantDto.fromJson(await _remote.patch(id, changes)).toEntity();
        await CacheManager.instance.invalidate(_cacheKey);
        return updated;
      });

  @override
  Future<void> deletePlant(String id) => guardCall(() async {
        await _remote.remove(id);
        await CacheManager.instance.invalidate(_cacheKey);
      });

  @override
  Future<Plant> uploadImage(String id, String filePath) => guardCall(() async {
        final updated = PlantDto.fromJson(await _remote.uploadImage(id, filePath)).toEntity();
        await CacheManager.instance.invalidate(_cacheKey);
        return updated;
      });
}
