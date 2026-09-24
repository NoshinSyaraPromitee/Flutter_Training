import 'package:plantpal/features/plants/domain/model/plant.dart';

abstract class PlantRepository {
  Future<List<Plant>> getPlants({bool forceRefresh = false});
  Future<Plant> addPlant(NewPlant plant);
  Future<Plant> updatePlant(String id, Map<String, dynamic> changes);
  Future<void> deletePlant(String id);
  Future<Plant> uploadImage(String id, String filePath);
}