enum DailyTaskKind { moisture, light, mist, dust, pests }

enum ProblemKind { yellowLeaves, brownTips, drooping }

class DailyCareTask {
  const DailyCareTask(this.kind, this.label);
  final DailyTaskKind kind;
  final String label;
}

class CommonProblem {
  const CommonProblem(this.kind, this.title, this.fix);
  final ProblemKind kind;
  final String title;
  final String fix;
}

/// Static care guidance for a plant — general-purpose today; could be
/// keyed off species once we have a larger reference dataset.
class CareGuide {
  const CareGuide({
    required this.title,
    required this.species,
    required this.water,
    required this.sunlight,
    required this.temperature,
    required this.fertilizer,
    required this.humidity,
    required this.dailyTasks,
    required this.proTips,
    required this.problems,
  });

  final String title;
  final String species;
  final String water;
  final String sunlight;
  final String temperature;
  final String fertilizer;
  final String humidity;
  final List<DailyCareTask> dailyTasks;
  final List<String> proTips;
  final List<CommonProblem> problems;
}
