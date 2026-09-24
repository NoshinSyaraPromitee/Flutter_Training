import 'package:plantpal/core/network/failure.dart';
import 'package:plantpal/features/plants/data/datasources/plant_remote_data_source.dart';
import 'package:plantpal/features/plants/data/models/plant_dto.dart';
import 'package:plantpal/features/plants/domain/model/plant.dart';
import 'package:plantpal/features/plants/domain/repositories/plant_repository.dart';

class PlantRepositoryImpl implements PlantRepository {
  PlantRepositoryImpl(this._remote);
  final PlantRemoteDataSource _remote;

  @override
  Future<List<Plant>> getPlants({bool forceRefresh = false}) => guardCall(() async {
        return (await _remote.fetchAll()).map((j) => PlantDto.fromJson(j).toEntity()).toList();
      });

  @override
  Future<Plant> addPlant(NewPlant plant) => guardCall(() async {
        return PlantDto.fromJson(await _remote.create(PlantDto.newPlantToJson(plant))).toEntity();
      });

  @override
  Future<Plant> updatePlant(String id, Map<String, dynamic> changes) => guardCall(() async {
        return PlantDto.fromJson(await _remote.patch(id, changes)).toEntity();
      });

  @override
  Future<void> deletePlant(String id) => guardCall(() async {
        await _remote.remove(id);
      });

  @override
  Future<Plant> uploadImage(String id, String filePath) => guardCall(() async {
        return PlantDto.fromJson(await _remote.uploadImage(id, filePath)).toEntity();
      });
}