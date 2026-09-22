import 'my_plants_repository.dart';
import '../domain/plant.dart';

/// No plant-inventory backend yet (see CLAUDE.md: `Plants` collection) —
/// each session starts with an empty collection.
class LocalMyPlantsRepository implements MyPlantsRepository {
  @override
  List<Plant> initial() => const [];
}
