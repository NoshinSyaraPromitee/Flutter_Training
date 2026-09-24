import '../../domain/entities/care_guide.dart';
import '../../domain/repositories/care_guide_repository.dart';
import '../../../plants/domain/entities/plant.dart';

class CareGuideLocalRepository implements CareGuideRepository {
  static const _tips = [
    'Rotate your plant a quarter turn every week so it grows evenly toward the light.',
    'Let the top inch of soil dry out before watering again to avoid root rot.',
    'Wipe leaves with a damp cloth monthly so they can breathe and photosynthesize better.',
    'Repot every 12–18 months into a pot just one size larger than the current one.',
  ];

  static const _problems = [
    CommonProblem(ProblemKind.yellowLeaves, 'Yellow leaves', 'Usually overwatering. Let soil dry out more between waterings.'),
    CommonProblem(ProblemKind.brownTips, 'Brown, crispy tips', 'Low humidity or too much direct sun. Mist leaves or move away from windows.'),
    CommonProblem(ProblemKind.drooping, 'Drooping stems', 'Thirsty plant or shock from a recent move. Water thoroughly and give it a few days.'),
  ];

  String _or(String v) => v.trim().isEmpty ? '—' : v;

  @override
  CareGuide guideFor(Plant? p) => CareGuide(
        title: p?.nickname ?? 'Plant Care 101',
        species: p?.species ?? 'Category – General Houseplant',
        water: p?.waterLevel ?? 'Twice a week',
        sunlight: p == null ? 'Bright indirect light' : _or(p.sunlight),
        temperature: '20°C – 28°C',
        fertilizer: p == null ? 'Every 2 weeks' : _or(p.fertilizerNote),
        humidity: p == null ? '60%' : _or(p.humidity),
        dailyTasks: [
          DailyCareTask(DailyTaskKind.moisture, p == null ? 'Check soil moisture' : 'Water: ${p.waterLevel}'),
          DailyCareTask(DailyTaskKind.light, p == null ? "Make sure it's getting enough light" : 'Sunlight: ${_or(p.sunlight)}'),
          const DailyCareTask(DailyTaskKind.mist, 'Mist the leaves'),
          const DailyCareTask(DailyTaskKind.dust, 'Wipe dust off the leaves'),
          const DailyCareTask(DailyTaskKind.pests, 'Look for pests or yellow leaves'),
        ],
        proTips: _tips,
        problems: _problems,
      );
}