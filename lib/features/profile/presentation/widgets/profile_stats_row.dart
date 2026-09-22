import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';

/// Points / badges summary shown at the top of the profile tab.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.points,
    required this.unlockedCount,
  });

  final int points;
  final int unlockedCount;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          _Stat(value: '$points', label: 'Points'),
          _Stat(value: '$unlockedCount', label: 'Badges'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.displayMedium.copyWith(
              fontSize: 22,
              color: AppColors.green,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
