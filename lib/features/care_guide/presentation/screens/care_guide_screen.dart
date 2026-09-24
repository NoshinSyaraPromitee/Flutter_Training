import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/features/care_guide/domain/model/care_guide.dart';
import 'package:plantpal/features/care_guide/domain/repositories/care_guide_repository.dart';
import 'package:plantpal/features/care_guide/presentation/widgets/care_guide_sections.dart';
import 'package:plantpal/features/care_guide/presentation/widgets/care_guide_tips_problems.dart';
import 'package:plantpal/features/plants/presentation/providers/plants_provider.dart';
import 'package:provider/provider.dart';

class CareGuideScreen extends StatefulWidget {
  const CareGuideScreen({super.key, this.plantId});
  final String? plantId;
  @override
  State<CareGuideScreen> createState() => _CareGuideScreenState();
}

class _CareGuideScreenState extends State<CareGuideScreen> {
  final _done = <int>{};

  IconData _taskIcon(DailyTaskKind k) => switch (k) {
        DailyTaskKind.moisture => Icons.water_drop_outlined,
        DailyTaskKind.light => Icons.wb_sunny_outlined,
        DailyTaskKind.mist => Icons.water,
        DailyTaskKind.dust => Icons.cleaning_services,
        DailyTaskKind.pests => Icons.search,
      };

  (IconData, Color) _problemStyle(ProblemKind k) => switch (k) {
        ProblemKind.yellowLeaves => (Icons.error_outline, const Color(0xFFE53935)),
        ProblemKind.brownTips => (Icons.local_fire_department, const Color(0xFFFB8C00)),
        ProblemKind.drooping => (Icons.arrow_circle_down, const Color(0xFF5C6BC0)),
      };

  @override
  Widget build(BuildContext context) {
    final plant = widget.plantId == null ? null : context.watch<PlantsController>().byId(widget.plantId!);
    final g = context.read<CareGuideRepository>().guideFor(plant);
    final total = g.dailyTasks.length;
    final essentials = <(IconData, Color, String, String)>[
      (Icons.water_drop, AppColors.waterBlue, 'Water', g.water),
      (Icons.wb_sunny, AppColors.sunAmber, 'Sunlight', g.sunlight),
      (Icons.thermostat, AppColors.danger, 'Temp', g.temperature),
      (Icons.eco, const Color(0xFF43A047), 'Fertilizer', g.fertilizer),
      (Icons.opacity, const Color(0xFF00ACC1), 'Humidity', g.humidity),
    ];
    final cardWidth = (MediaQuery.of(context).size.width - 40 - 12) / 2;

    return AppScreen(
      title: 'Care Guide',
      child: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF43A047)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(g.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.inter(24, w: FontWeight.w800, c: Colors.white)),
            const SizedBox(height: 4),
            Text(g.species, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.inter(14, c: Colors.white70)),
          ]),
        ),
        SectionTitle(
          "Today's Care Challenge",
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.surfaceGreen, borderRadius: BorderRadius.circular(12)),
            child: Text('${_done.length}/$total', style: AppTextStyles.inter(12, w: FontWeight.w700, c: AppColors.greenPrimary)),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(value: _done.length / total, minHeight: 8, color: AppColors.greenPrimary, backgroundColor: Colors.white),
        ),
        const SizedBox(height: 12),
        CareGuideChecklist(
          tasks: g.dailyTasks,
          done: _done,
          taskIcon: _taskIcon,
          onToggle: (i) => setState(() => _done.contains(i) ? _done.remove(i) : _done.add(i)),
        ),
        const SectionTitle('Essentials'),
        CareGuideEssentials(items: essentials, cardWidth: cardWidth),
        const SectionTitle('Pro Tips'),
        CareGuideProTips(tips: g.proTips),
        const SectionTitle('Common Problems'),
        CareGuideProblems(problems: g.problems, styleFor: _problemStyle),
      ]),
    );
  }
}
