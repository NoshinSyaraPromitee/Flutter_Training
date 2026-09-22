import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/utils/formatters.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/gradient_background.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/plants/domain/model/plant.dart';
import 'package:plantpal/features/plants/presentation/controllers/plants_controller.dart';
import 'package:plantpal/features/plants/presentation/widgets/health_badge.dart';
import 'package:plantpal/features/plants/presentation/widgets/plant_details_header.dart';
import 'package:plantpal/features/plants/presentation/widgets/plant_stat_tiles.dart';
import 'package:provider/provider.dart';

class PlantDetailsScreen extends StatelessWidget {
  const PlantDetailsScreen({super.key, required this.plantId});
  final String plantId;

  Future<void> _onMenu(BuildContext context, String action, Plant plant) async {
    final c = context.read<PlantsController>();
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    if (action == 'water') {
      final err = await c.markWatered(plant.id);
      messenger.showSnackBar(SnackBar(content: Text(err ?? '${plant.nickname} marked as watered 💧')));
      return;
    }
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete plant?'),
        content: Text('${plant.nickname} will be removed from your collection.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: AppColors.danger))),
        ],
      ),
    );
    if (ok != true) return;
    final err = await c.remove(plant.id);
    if (err != null) {
      messenger.showSnackBar(SnackBar(content: Text(err)));
    } else if (router.canPop()) {
      router.pop();
    } else {
      router.go('/plants');
    }
  }

  @override
  Widget build(BuildContext context) {
    final plant = context.watch<PlantsController>().byId(plantId);
    if (plant == null) return const AppScreen(title: 'Plant', child: ErrorView(message: 'Plant not found.'));

    return Scaffold(
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Column(children: [
            PlantDetailsHeader(
              imageUrl: plant.imageUrl,
              onBack: () => context.canPop() ? context.pop() : context.go('/plants'),
              onMenuSelected: (v) => _onMenu(context, v, plant),
            ),
            Container(
              transform: Matrix4.translationValues(0, -28, 0),
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(plant.nickname, style: AppTextStyles.screenTitle),
                Text(plant.species, style: AppTextStyles.inter(16, c: AppColors.textMuted)),
                const SizedBox(height: 12),
                HealthBadge(health: plant.health),
                const SizedBox(height: 16),
                Row(children: [
                  PlantStatTile(icon: Icons.water_drop, color: AppColors.waterBlue, title: 'Water', value: plant.waterLevel),
                  PlantStatTile(icon: Icons.wb_sunny, color: AppColors.sunAmber, title: 'Sunlight', value: plant.sunlight),
                ]),
                Row(children: [
                  PlantStatTile(icon: Icons.location_on, color: AppColors.greenPrimary, title: 'Location', value: plant.location),
                  PlantStatTile(icon: Icons.opacity, color: const Color(0xFF00ACC1), title: 'Humidity', value: plant.humidity),
                ]),
                const SectionTitle("Today's Care"),
                PlantTaskRow(icon: Icons.check_circle, color: const Color(0xFF4CAF50), text: 'Water: ${plant.waterLevel}'),
                PlantTaskRow(
                  icon: Icons.local_florist,
                  color: const Color(0xFFFB8C00),
                  text: plant.fertilizerNote.isEmpty ? 'No fertilizer note yet' : 'Fertilize: ${plant.fertilizerNote}',
                ),
                PlantTaskRow(icon: Icons.photo_camera_outlined, color: const Color(0xFF5C6BC0), text: 'Last scan: ${relativeDay(plant.lastScan)}'),
                const SizedBox(height: 8),
                SizedBox(width: double.infinity, child: AppButton(label: 'Scan Again', trailingIcon: Icons.photo_camera, onPressed: () => context.go('/scan'))),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity, child: AppButton(label: 'Ask AI Doctor', variant: AppButtonVariant.orange, trailingIcon: Icons.smart_toy, onPressed: () => context.go('/ai-doctor'))),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity, child: AppButton(label: 'Care Guide', trailingIcon: Icons.eco, onPressed: () => context.push('/care-guide?plantId=${plant.id}'))),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
