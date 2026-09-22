import '../domain/care_guide.dart';

/// A generic, static care guide. There's no species-specific database yet,
/// so every plant gets the same general-purpose guidance for now.
class LocalCareGuideRepository {
  const LocalCareGuideRepository();

  CareGuide guideFor({String? plantName, String? species}) {
    return CareGuide(
      title: plantName ?? 'General Plant Care',
      species: species ?? 'Most common houseplants',
      water: 'Every 5–7 days',
      sunlight: 'Bright, indirect',
      temperature: '18–27°C',
      fertilizer: 'Balanced NPK, monthly',
      humidity: 'Moderate (40–60%)',
      dailyTasks: const [
        DailyCareTask(DailyTaskKind.moisture, 'Check soil moisture'),
        DailyCareTask(DailyTaskKind.light, 'Confirm it’s getting enough light'),
        DailyCareTask(DailyTaskKind.mist, 'Mist leaves if the air is dry'),
        DailyCareTask(DailyTaskKind.dust, 'Wipe dust off large leaves'),
        DailyCareTask(
          DailyTaskKind.pests,
          'Look for pests on the underside of leaves',
        ),
      ],
      proTips: const [
        'Water in the morning so leaves dry before nightfall.',
        'Rotate the pot every couple of weeks for even growth.',
        'Repot when roots start circling the bottom of the pot.',
      ],
      problems: const [
        CommonProblem(
          ProblemKind.yellowLeaves,
          'Yellowing leaves',
          'Usually overwatering — let the topsoil dry out between waterings.',
        ),
        CommonProblem(
          ProblemKind.brownTips,
          'Brown leaf tips',
          'Often low humidity or fluoride in tap water — try filtered water.',
        ),
        CommonProblem(
          ProblemKind.drooping,
          'Drooping stems',
          'Usually underwatering or too little light — check both before repotting.',
        ),
      ],
    );
  }
}
