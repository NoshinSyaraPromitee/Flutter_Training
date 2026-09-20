import 'plant.dart';

abstract class PlantRepository {
  Future<Plant> create({
    required String name,
    required String type,
    required String ageStage,
  });
}
