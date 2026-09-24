import 'package:flutter/foundation.dart';
import '../../../../core/network/failure.dart';
import '../../domain/entities/plant.dart';
import '../../domain/repositories/plant_repository.dart';
import '../../domain/usecases/add_plant.dart';

class PlantsController extends ChangeNotifier {
  PlantsController({required PlantRepository repository, required AddPlant addPlant})
      : _repo = repository,
        _add = addPlant;
  final PlantRepository _repo;
  final AddPlant _add;

  List<Plant> plants = const [];
  bool loading = false;
  bool loaded = false;
  String? error;

  Future<void> load({bool force = false}) async {
    if (loading || (loaded && !force)) return;
    loading = true;
    error = null;
    notifyListeners();
    try {
      plants = await _repo.getPlants();
      loaded = true;
    } catch (e) {
      error = Failure.from(e).message;
    }
    loading = false;
    notifyListeners();
  }

  Plant? byId(String id) {
    for (final p in plants) {
      if (p.id == id) return p;
    }
    return null;
  }

  int get averageHealth {
    final scanned = plants.where((p) => p.health != null).toList();
    if (scanned.isEmpty) return 0;
    return (scanned.fold<int>(0, (s, p) => s + p.health!) / scanned.length).round();
  }

  int get waterTodayCount => plants.where((p) => p.waterLevel == 'Today').length;

  /// Each action returns an error message, or null on success.
  Future<String?> add(NewPlant input) => _run(() async {
        final created = await _add(input);
        plants = [created, ...plants];
      });

  Future<String?> markWatered(String id) => _run(() async {
        final updated = await _repo.updatePlant(id, {'lastWatered': DateTime.now().toUtc().toIso8601String()});
        plants = [for (final p in plants) p.id == id ? updated : p];
      });

  Future<String?> updateDetails({
    required String id,
    required String nickname,
    required String species,
    required String location,
    required String sunlight,
    required int wateringFrequencyDays,
  }) =>
      _run(() async {
        final updated = await _repo.updatePlant(id, {
          'nickname': nickname,
          'species': species,
          'location': location,
          'sunlight': sunlight,
          'wateringFrequencyDays': wateringFrequencyDays,
        });
        plants = [for (final p in plants) p.id == id ? updated : p];
      });

  Future<String?> remove(String id) => _run(() async {
        await _repo.deletePlant(id);
        plants = plants.where((p) => p.id != id).toList();
      });

  Future<String?> _run(Future<void> Function() action) async {
    try {
      await action();
      notifyListeners();
      return null;
    } catch (e) {
      return Failure.from(e).message;
    }
  }

  void clear() {
    plants = const [];
    loaded = false;
    error = null;
    notifyListeners();
  }
}