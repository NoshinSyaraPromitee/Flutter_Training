import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';

/// A single essential fact: icon, accent color, label, value.
typedef Essential = (IconData, Color, String, String);

/// "ESSENTIALS" section label + a two-column wrap of fact cards.
class EssentialsGrid extends StatelessWidget {
  const EssentialsGrid({super.key, required this.essentials});

  final List<Essential> essentials;

  @override
  Widget build(BuildContext context) {
    final cardWidth =
        (MediaQuery.of(context).size.width -
            AppSpacing.xl * 2 -
            AppSpacing.md) /
        2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('ESSENTIALS', style: AppTextStyles.sectionLabel),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final e in essentials)
              SizedBox(
                width: cardWidth,
                child: AppCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: e.$2.withValues(alpha: 0.12),
                        child: Icon(e.$1, size: 20, color: e.$2),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.$3, style: AppTextStyles.caption),
                            Text(
                              e.$4,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyText.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
