import 'package:plantpal/core/network/failure.dart';
import 'package:plantpal/features/plants/domain/entities/plant.dart';
import 'package:plantpal/features/plants/domain/repositories/plant_repository.dart';

/// Validates, creates the plant, then attaches its photo (if any).
class AddPlant {
  AddPlant(this._repo);
  final PlantRepository _repo;

  Future<Plant> call(NewPlant input) async {
    final error = input.validate();
    if (error != null) throw Failure(error);
    var plant = await _repo.addPlant(input);
    final path = input.imagePath;
    if (path != null) plant = await _repo.uploadImage(plant.id, path);
    return plant;
  }
}