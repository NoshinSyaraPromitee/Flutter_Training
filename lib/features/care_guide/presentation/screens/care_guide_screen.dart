import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../my_plants/presentation/providers/my_plants_providers.dart';
import '../../repository/local_care_guide_repository.dart';
import '../widgets/care_progress_header.dart';
import '../widgets/common_problems_list.dart';
import '../widgets/daily_checklist_card.dart';
import '../widgets/essentials_grid.dart';
import '../widgets/pro_tips_card.dart';

/// [plantId] is optional — pass it to personalize the title with a
/// tracked plant's name/species; omit it for the generic guide.
class CareGuideScreen extends ConsumerStatefulWidget {
  const CareGuideScreen({super.key, this.plantId});

  final String? plantId;

  @override
  ConsumerState<CareGuideScreen> createState() => _CareGuideScreenState();
}

class _CareGuideScreenState extends ConsumerState<CareGuideScreen> {
  final _done = <int>{};
  static const _repo = LocalCareGuideRepository();

  @override
  Widget build(BuildContext context) {
    final plant = widget.plantId == null
        ? null
        : ref.watch(myPlantsProvider.notifier).byId(widget.plantId!);
    final guide = _repo.guideFor(
      plantName: plant?.nickname,
      species: plant?.species,
    );
    final total = guide.dailyTasks.length;
    final essentials = <Essential>[
      (Icons.water_drop, AppColors.teal, 'Water', guide.water),
      (Icons.wb_sunny, AppColors.orange, 'Sunlight', guide.sunlight),
      (Icons.thermostat, AppColors.danger, 'Temp', guide.temperature),
      (Icons.eco, AppColors.green, 'Fertilizer', guide.fertilizer),
      (Icons.opacity, AppColors.teal, 'Humidity', guide.humidity),
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'Care Guide',
            subtitle: guide.title,
            color: AppColors.green,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                CareProgressHeader(done: _done.length, total: total),
                const SizedBox(height: AppSpacing.md),
                DailyChecklistCard(
                  tasks: guide.dailyTasks,
                  done: _done,
                  onToggle: (i) => setState(
                    () => _done.contains(i) ? _done.remove(i) : _done.add(i),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                EssentialsGrid(essentials: essentials),
                const SizedBox(height: AppSpacing.lg),
                ProTipsCard(tips: guide.proTips),
                const SizedBox(height: AppSpacing.lg),
                CommonProblemsList(problems: guide.problems),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
