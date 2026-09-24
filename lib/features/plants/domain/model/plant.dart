class Plant {
  const Plant({
    required this.id,
    required this.nickname,
    required this.species,
    this.imageUrl = '',
    this.location = '',
    this.sunlight = '',
    this.health,
    this.status = '',
    this.humidity = '',
    this.lastScan,
    this.wateringFrequencyDays = 7,
    this.lastWatered,
    this.nextWatering,
    this.waterLevel = 'Not set',
    this.fertilizerNote = '',
  });

  final String id, nickname, species, imageUrl, location, sunlight, status, humidity, waterLevel, fertilizerNote;
  final int? health; // 0-100, null until scanned
  final int wateringFrequencyDays;
  final DateTime? lastScan, lastWatered, nextWatering;
}

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

  final String nickname, species, location, sunlight;
  final int wateringFrequencyDays;
  final DateTime? lastWatered;
  final String? imagePath;

  String? validate() {
    if (nickname.trim().isEmpty || species.trim().isEmpty) {
      return 'Please enter at least the plant nickname and species.';
    }
    if (wateringFrequencyDays < 1) return 'Watering interval must be at least 1 day.';
    return null;
  }
}