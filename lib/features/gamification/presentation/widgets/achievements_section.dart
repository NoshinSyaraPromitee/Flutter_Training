import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/gamification_providers.dart';

/// Points summary + achievement badge grid, embedded on Profile.
class AchievementsSection extends ConsumerWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievements = ref.watch(achievementsProvider);
    final points = ref.watch(pointsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('ACHIEVEMENTS', style: AppTextStyles.sectionLabel),
            const Spacer(),
            Icon(Icons.stars_rounded, size: 16, color: AppColors.orange),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '$points pts',
              style: AppTextStyles.bodyText.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final (i, achievement) in achievements.indexed)
              _AchievementBadge(
                title: achievement.title,
                icon: achievement.icon,
                unlocked: achievement.unlocked,
                color: AppColors
                    .accentRotation[i % AppColors.accentRotation.length],
              ),
          ],
        ),
      ],
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  const _AchievementBadge({
    required this.title,
    required this.icon,
    required this.unlocked,
    required this.color,
  });

  final String title;
  final IconData icon;
  final bool unlocked;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: unlocked
                  ? color.withValues(alpha: 0.14)
                  : AppColors.textSecondary.withValues(alpha: 0.1),
            ),
            child: Icon(
              unlocked ? icon : Icons.lock_outline,
              size: 22,
              color: unlocked ? color : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: unlocked ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
