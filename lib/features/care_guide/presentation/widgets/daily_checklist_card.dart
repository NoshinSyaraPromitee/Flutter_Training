import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/care_guide.dart';

IconData taskIcon(DailyTaskKind kind) => switch (kind) {
  DailyTaskKind.moisture => Icons.water_drop_outlined,
  DailyTaskKind.light => Icons.wb_sunny_outlined,
  DailyTaskKind.mist => Icons.water,
  DailyTaskKind.dust => Icons.cleaning_services_outlined,
  DailyTaskKind.pests => Icons.search,
};

/// Checklist of a guide's daily care tasks, with tap-to-toggle checkboxes.
class DailyChecklistCard extends StatelessWidget {
  const DailyChecklistCard({
    super.key,
    required this.tasks,
    required this.done,
    required this.onToggle,
  });

  final List<DailyCareTask> tasks;
  final Set<int> done;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    final total = tasks.length;
    return AppCard(
      child: Column(
        children: [
          for (var i = 0; i < total; i++)
            InkWell(
              onTap: () => onToggle(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Row(
                  children: [
                    Icon(
                      done.contains(i)
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: done.contains(i)
                          ? AppColors.green
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(
                      taskIcon(tasks[i].kind),
                      size: 18,
                      color: done.contains(i)
                          ? AppColors.textSecondary
                          : AppColors.green,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        tasks[i].label,
                        style: AppTextStyles.bodyText.copyWith(
                          color: done.contains(i)
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                          decoration: done.contains(i)
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (total > 0 && done.length == total)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Row(
                children: [
                  Icon(
                    Icons.celebration_outlined,
                    size: 18,
                    color: AppColors.green,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'All done! Your plant is thriving today.',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
