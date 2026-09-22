import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/features/care_guide/domain/model/care_guide.dart';

/// Today's checklist of daily tasks, with a "all done" celebration footer.
class CareGuideChecklist extends StatelessWidget {
  const CareGuideChecklist({
    super.key,
    required this.tasks,
    required this.done,
    required this.taskIcon,
    required this.onToggle,
  });

  final List<DailyCareTask> tasks;
  final Set<int> done;
  final IconData Function(DailyTaskKind) taskIcon;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(children: [
        for (var i = 0; i < tasks.length; i++)
          InkWell(
            onTap: () => onToggle(i),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(children: [
                Icon(done.contains(i) ? Icons.check_box : Icons.check_box_outline_blank,
                    color: done.contains(i) ? AppColors.greenPrimary : Colors.black38),
                const SizedBox(width: 10),
                Icon(taskIcon(tasks[i].kind), size: 18, color: done.contains(i) ? Colors.black26 : AppColors.greenPrimary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    tasks[i].label,
                    style: AppTextStyles.inter(14, c: done.contains(i) ? Colors.black38 : AppColors.textDark).copyWith(
                      decoration: done.contains(i) ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        if (done.length == tasks.length)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(children: [
              const Icon(Icons.celebration, size: 18, color: AppColors.greenPrimary),
              const SizedBox(width: 8),
              Text('All done! Your plant is thriving today.', style: AppTextStyles.inter(13, w: FontWeight.w600, c: AppColors.greenPrimary)),
            ]),
          ),
      ]),
    );
  }
}

/// "Essentials" wrap of water / sunlight / temp / fertilizer / humidity cards.
class CareGuideEssentials extends StatelessWidget {
  const CareGuideEssentials({super.key, required this.items, required this.cardWidth});

  final List<(IconData, Color, String, String)> items;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final e in items)
          SizedBox(
            width: cardWidth,
            child: AppCard(
              padding: const EdgeInsets.all(12),
              child: Row(children: [
                CircleAvatar(backgroundColor: e.$2.withValues(alpha: 0.12), child: Icon(e.$1, size: 20, color: e.$2)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e.$3, style: AppTextStyles.inter(12, c: AppColors.textMuted)),
                    Text(e.$4, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.inter(13, w: FontWeight.w700)),
                  ]),
                ),
              ]),
            ),
          ),
      ],
    );
  }
}
