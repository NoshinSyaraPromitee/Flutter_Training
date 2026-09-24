import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/features/care_guide/domain/model/care_guide.dart';

/// Numbered "Pro Tips" list.
class CareGuideProTips extends StatelessWidget {
  const CareGuideProTips({super.key, required this.tips});
  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(children: [
        for (var i = 0; i < tips.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                radius: 11,
                backgroundColor: AppColors.greenPrimary,
                child: Text('${i + 1}', style: AppTextStyles.inter(11, w: FontWeight.w700, c: Colors.white)),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(tips[i], style: AppTextStyles.inter(13, h: 1.4))),
            ]),
          ),
      ]),
    );
  }
}

/// "Common Problems" card list.
class CareGuideProblems extends StatelessWidget {
  const CareGuideProblems({super.key, required this.problems, required this.styleFor});

  final List<CommonProblem> problems;
  final (IconData, Color) Function(ProblemKind) styleFor;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (final p in problems)
        AppCard(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(children: [
            CircleAvatar(
              backgroundColor: styleFor(p.kind).$2.withValues(alpha: 0.12),
              child: Icon(styleFor(p.kind).$1, color: styleFor(p.kind).$2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.title, style: AppTextStyles.inter(14, w: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(p.fix, style: AppTextStyles.inter(12, c: AppColors.textMuted, h: 1.4)),
              ]),
            ),
          ]),
        ),
    ]);
  }
}
