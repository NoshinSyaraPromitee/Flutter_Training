/// A plant the user is tracking in their local collection — distinct from
/// `features/plants`, which is the real backend-wired care-roadmap
/// generator. This is purely local/in-memory (no backend for it yet).
class Plant {
  const Plant({
    required this.id,
    required this.nickname,
    required this.species,
    this.imagePath,
    this.location = '',
    this.sunlight = '',
    this.health,
    this.humidity = '',
    this.waterLevel = 'Not set',
    this.fertilizerNote = '',
    this.wateringFrequencyDays = 7,
    this.lastWatered,
    this.lastScan,
    this.addedAt,
  });

  final String id;
  final String nickname;
  final String species;
  final String? imagePath;
  final String location;
  final String sunlight;
  final int? health; // 0-100, null until scanned
  final String humidity;
  final String waterLevel;
  final String fertilizerNote;
  final int wateringFrequencyDays;
  final DateTime? lastWatered;
  final DateTime? lastScan;
  final DateTime? addedAt;

  Plant copyWith({
    int? health,
    String? waterLevel,
    DateTime? lastWatered,
    DateTime? lastScan,
  }) {
    return Plant(
      id: id,
      nickname: nickname,
      species: species,
      imagePath: imagePath,
      location: location,
      sunlight: sunlight,
      health: health ?? this.health,
      humidity: humidity,
      waterLevel: waterLevel ?? this.waterLevel,
      fertilizerNote: fertilizerNote,
      wateringFrequencyDays: wateringFrequencyDays,
      lastWatered: lastWatered ?? this.lastWatered,
      lastScan: lastScan ?? this.lastScan,
      addedAt: addedAt,
    );
  }
}

/// The fields collected on the "Add Plant" form.
class NewPlant {
  const NewPlant({
    required this.nickname,
    required this.species,
    this.location = '',
    this.sunlight = '',
    this.wateringFrequencyDays = 7,
    this.lastWatered,
    this.imagePath,
  });

  final String nickname;
  final String species;
  final String location;
  final String sunlight;
  final int wateringFrequencyDays;
  final DateTime? lastWatered;
  final String? imagePath;

  /// Returns a validation error message, or null if valid.
  String? validate() {
    if (nickname.trim().isEmpty || species.trim().isEmpty) {
      return 'Please enter at least the plant nickname and species.';
    }
    if (wateringFrequencyDays < 1)
      return 'Watering interval must be at least 1 day.';
    return null;
  }
}

/// A watering/scan event, used on the Plant History screen.
enum HistoryAction { scan, water }

class HistoryEntry {
  const HistoryEntry({
    required this.plant,
    required this.action,
    required this.date,
    required this.note,
  });

  final Plant plant;
  final HistoryAction action;
  final DateTime date;
  final String note;
}

enum CareTaskType { water, fertilize }

enum CareTaskGroup { today, tomorrow, later }

class CareTask {
  const CareTask({
    required this.id,
    required this.plant,
    required this.type,
    required this.group,
  });

  final String id;
  final Plant plant;
  final CareTaskType type;
  final CareTaskGroup group;
}
