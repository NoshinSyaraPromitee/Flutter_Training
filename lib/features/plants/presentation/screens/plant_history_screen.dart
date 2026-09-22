import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/utils/formatters.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/net_image.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/plants/domain/usecases/plant_history.dart';
import 'package:plantpal/features/plants/presentation/controllers/plants_controller.dart';
import 'package:provider/provider.dart';

class PlantHistoryScreen extends StatefulWidget {
  const PlantHistoryScreen({super.key});
  @override
  State<PlantHistoryScreen> createState() => _PlantHistoryScreenState();
}

class _PlantHistoryScreenState extends State<PlantHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<PlantsController>().load());
  }

  @override
  Widget build(BuildContext context) {
    final history = const BuildPlantHistory()(context.watch<PlantsController>().plants);

    return AppScreen(
      title: 'Plant History',
      child: history.isEmpty
          ? const EmptyView(icon: Icons.history, title: 'No activity yet', subtitle: 'Scan or water a plant to get started!')
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              itemCount: history.length,
              itemBuilder: (_, i) {
                final e = history[i];
                final scan = e.action == HistoryAction.scan;
                final color = scan ? AppColors.greenPrimary : AppColors.waterBlue;
                return IntrinsicHeight(
                  child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    SizedBox(
                      width: 36,
                      child: Column(children: [
                        CircleAvatar(radius: 16, backgroundColor: color, child: Icon(scan ? Icons.eco : Icons.water_drop, size: 16, color: Colors.white)),
                        if (i != history.length - 1) Expanded(child: Container(width: 2, margin: const EdgeInsets.symmetric(vertical: 4), color: Colors.black12)),
                      ]),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppCard(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(12),
                        radius: 18,
                        onTap: () => context.push('/plants/${e.plant.id}'),
                        child: Row(children: [
                          NetImage(e.plant.imageUrl, width: 52, height: 52, radius: 14),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('${scan ? 'AI Scan' : 'Watered'} • ${e.plant.nickname}', style: AppTextStyles.inter(14, w: FontWeight.w600)),
                              Text(e.note, style: AppTextStyles.inter(12, c: AppColors.textMuted)),
                              Text(relativeDay(e.date), style: AppTextStyles.inter(12, w: FontWeight.w600, c: const Color(0xFF43A047))),
                            ]),
                          ),
                        ]),
                      ),
                    ),
                  ]),
                );
              },
            ),
    );
  }
}