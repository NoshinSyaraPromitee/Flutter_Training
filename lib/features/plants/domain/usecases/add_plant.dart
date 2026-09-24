import '../../../../core/network/failure.dart';
import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

/// Validates, creates the plant, then attaches its photo (if any).
class AddPlant {
  AddPlant(this._repo);
  final PlantRepository _repo;

  Future<Plant> call(NewPlant input) async {
    final error = input.validate();
    if (error != null) throw Failure(error);
    var plant = await _repo.addPlant(input);
    final imageBytes = input.imageBytes;
    if (imageBytes != null) {
      plant = await _repo.uploadImage(plant.id, imageBytes);
    }
    return plant;
  }
}
