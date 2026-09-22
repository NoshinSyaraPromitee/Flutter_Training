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
  final String title, fix;
}

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
  final String title, species, water, sunlight, temperature, fertilizer, humidity;
  final List<DailyCareTask> dailyTasks;
  final List<String> proTips;
  final List<CommonProblem> problems;
}