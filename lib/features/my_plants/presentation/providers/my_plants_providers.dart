import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/plant.dart';
import '../../repository/local_my_plants_repository.dart';
import '../../repository/my_plants_repository.dart';

part 'my_plants_providers.g.dart';

@Riverpod(keepAlive: true)
MyPlantsRepository myPlantsRepository(Ref ref) => LocalMyPlantsRepository();

@Riverpod(keepAlive: true)
class MyPlants extends _$MyPlants {
  @override
  List<Plant> build() => ref.watch(myPlantsRepositoryProvider).initial();

  Plant? byId(String id) {
    for (final p in state) {
      if (p.id == id) return p;
    }
    return null;
  }

  String? add(NewPlant input) {
    final error = input.validate();
    if (error != null) return error;
    final plant = Plant(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      nickname: input.nickname.trim(),
      species: input.species.trim(),
      imagePath: input.imagePath,
      location: input.location.trim(),
      sunlight: input.sunlight.trim(),
      wateringFrequencyDays: input.wateringFrequencyDays,
      lastWatered: input.lastWatered,
      waterLevel: input.lastWatered != null ? 'Just watered' : 'Not set',
      addedAt: DateTime.now(),
    );
    state = [...state, plant];
    return null;
  }

  void markWatered(String id) {
    state = [
      for (final p in state)
        if (p.id == id)
          p.copyWith(lastWatered: DateTime.now(), waterLevel: 'Just watered')
        else
          p,
    ];
  }

  void remove(String id) {
    state = state.where((p) => p.id != id).toList();
  }

  int get averageHealth {
    final scored = state.where((p) => p.health != null).toList();
    if (scored.isEmpty) return 0;
    return (scored.map((p) => p.health!).reduce((a, b) => a + b) /
            scored.length)
        .round();
  }

  int get waterTodayCount => state.where((p) {
    if (p.lastWatered == null) return true;
    final next = p.lastWatered!.add(Duration(days: p.wateringFrequencyDays));
    return !next.isAfter(DateTime.now());
  }).length;
}

/// Every plant's most recent scan/watering event, newest first.
@riverpod
List<HistoryEntry> plantHistory(Ref ref) {
  final plants = ref.watch(myPlantsProvider);
  final entries = <HistoryEntry>[];
  for (final p in plants) {
    if (p.lastScan != null) {
      entries.add(
        HistoryEntry(
          plant: p,
          action: HistoryAction.scan,
          date: p.lastScan!,
          note: 'Health check',
        ),
      );
    }
    if (p.lastWatered != null) {
      entries.add(
        HistoryEntry(
          plant: p,
          action: HistoryAction.water,
          date: p.lastWatered!,
          note: p.waterLevel,
        ),
      );
    }
  }
  entries.sort((a, b) => b.date.compareTo(a.date));
  return entries;
}

/// Watering/fertilizing tasks grouped into today/tomorrow/later, derived
/// from each plant's watering frequency.
@riverpod
List<CareTask> careTasks(Ref ref) {
  final plants = ref.watch(myPlantsProvider);
  final now = DateTime.now();
  final tasks = <CareTask>[];
  for (final p in plants) {
    final next =
        p.lastWatered?.add(Duration(days: p.wateringFrequencyDays)) ?? now;
    final daysUntil = next
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    final group = daysUntil <= 0
        ? CareTaskGroup.today
        : daysUntil == 1
        ? CareTaskGroup.tomorrow
        : CareTaskGroup.later;
    if (daysUntil <= 7) {
      tasks.add(
        CareTask(
          id: '${p.id}-water',
          plant: p,
          type: CareTaskType.water,
          group: group,
        ),
      );
    }
  }
  return tasks;
}
