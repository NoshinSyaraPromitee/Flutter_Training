/// The generated watering schedule and guidance returned by the backend
/// after "Create My Roadmap" on the Maintainance screen.
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

  factory CareRoadmap.fromJson(Map<String, dynamic> json) {
    return CareRoadmap(
      wateringTimes: (json['wateringTimes'] as List).cast<String>(),
      waterAmountMl: json['waterAmountMl'] as int,
      tips: json['tips'] as String,
      fertilizerRecommendation: json['fertilizerRecommendation'] as String,
    );
  }
}

/// A plant registered for care tracking, as returned by /api/v1/plants.
class Plant {
  const Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.ageStage,
    required this.careRoadmap,
  });

  final String id;
  final String name;
  final String type;
  final String ageStage;
  final CareRoadmap careRoadmap;

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String? ?? '',
      ageStage: json['ageStage'] as String? ?? '',
      careRoadmap: CareRoadmap.fromJson(
        json['careRoadmap'] as Map<String, dynamic>,
      ),
    );
  }
}
