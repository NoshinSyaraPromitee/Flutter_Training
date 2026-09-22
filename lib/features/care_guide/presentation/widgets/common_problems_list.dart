import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/care_guide.dart';

(IconData, Color) problemStyle(ProblemKind kind) => switch (kind) {
  ProblemKind.yellowLeaves => (Icons.error_outline, AppColors.danger),
  ProblemKind.brownTips => (
    Icons.local_fire_department_outlined,
    AppColors.orange,
  ),
  ProblemKind.drooping => (Icons.arrow_circle_down_outlined, AppColors.teal),
};

/// "COMMON PROBLEMS" section label + a card per known problem.
class CommonProblemsList extends StatelessWidget {
  const CommonProblemsList({super.key, required this.problems});

  final List<CommonProblem> problems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('COMMON PROBLEMS', style: AppTextStyles.sectionLabel),
        const SizedBox(height: AppSpacing.sm),
        for (final p in problems)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: AppCard(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: problemStyle(p.kind).$2
                        .withValues(alpha: 0.12),
                    child: Icon(
                      problemStyle(p.kind).$1,
                      color: problemStyle(p.kind).$2,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.title,
                          style: AppTextStyles.bodyText.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(p.fix, style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
