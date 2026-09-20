/// The generated watering schedule and guidance shown after "Create My
/// Roadmap" on the Maintainance screen.
class CareRoadmap {
  const CareRoadmap({
    required this.wateringTimes,
    required this.waterAmountMl,
    required this.tips,
    required this.fertilizerRecommendation,
  });

  final List<String> wateringTimes;
  final int waterAmountMl;
  final String tips;
  final String fertilizerRecommendation;
}

/// Derives a [CareRoadmap] from a plant's type and age stage.
///
/// This is a simple rule-based placeholder matching the backend's
/// `buildRoadmap` logic, kept local since this screen is UI-only for now.
CareRoadmap buildCareRoadmap({required String plantType, required String ageStage}) {
  var waterAmountMl = 200;
  var wateringTimes = const ['08:00', '18:00'];
  var tips = "Don't expose to excess sun; find a cool, dry place with plenty of indirect sunlight.";
  var fertilizer = 'Use a balanced NPK fertilizer every 2 weeks.';

  switch (ageStage.trim().toLowerCase()) {
    case 'seed':
    case 'seedling':
      waterAmountMl = 100;
      wateringTimes = const ['08:00'];
      fertilizer = 'Avoid fertilizer until the first true leaves appear.';
    case 'mature':
    case 'adult':
      waterAmountMl = 300;
      wateringTimes = const ['08:00', '12:00', '18:00'];
      fertilizer = 'Use Potassium (K) based fertilizer to support blooming.';
  }

  if (plantType.toLowerCase().contains('water')) {
    waterAmountMl += 100;
  }

  return CareRoadmap(
    wateringTimes: wateringTimes,
    waterAmountMl: waterAmountMl,
    tips: tips,
    fertilizerRecommendation: fertilizer,
  );
}
