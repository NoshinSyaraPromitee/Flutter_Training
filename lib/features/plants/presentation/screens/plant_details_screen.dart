import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_screen.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/widgets/net_image.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/entities/plant.dart';
import '../controllers/plants_controller.dart';
import '../widgets/health_badge.dart';
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

  Widget _tile(IconData i, Color c, String title, String value) => Expanded(
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Icon(i, size: 28, color: c),
            const SizedBox(height: 8),
            Text(title, style: AppTextStyles.inter(13, w: FontWeight.w600, c: Colors.black54)),
            const SizedBox(height: 4),
            Text(value.isEmpty ? '—' : value, textAlign: TextAlign.center, style: AppTextStyles.inter(15, w: FontWeight.w700, c: AppColors.greenPrimary)),
          ]),
        ),
      );

  Widget _task(IconData i, Color c, String text) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          Icon(i, color: c),
          const SizedBox(width: 14),
          Expanded(child: Text(text, style: AppTextStyles.inter(15, w: FontWeight.w600))),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final plant = context.watch<PlantsController>().byId(plantId);
    if (plant == null) return const AppScreen(title: 'Plant', child: ErrorView(message: 'Plant not found.'));

    return Scaffold(
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              NetImage(plant.imageUrl, width: double.infinity, height: 300, radius: 0),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    IconButton(
                      icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.arrow_back, color: AppColors.greenPrimary)),
                      onPressed: () => context.canPop() ? context.pop() : context.go('/plants'),
                    ),
                    PopupMenuButton<String>(
                      icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.more_vert, color: AppColors.greenPrimary)),
                      onSelected: (v) => _onMenu(context, v, plant),
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'water', child: Text('Mark as watered')),
                        PopupMenuItem(value: 'delete', child: Text('Delete plant')),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
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
                  _tile(Icons.water_drop, AppColors.waterBlue, 'Water', plant.waterLevel),
                  _tile(Icons.wb_sunny, AppColors.sunAmber, 'Sunlight', plant.sunlight),
                ]),
                Row(children: [
                  _tile(Icons.location_on, AppColors.greenPrimary, 'Location', plant.location),
                  _tile(Icons.opacity, const Color(0xFF00ACC1), 'Humidity', plant.humidity),
                ]),
                const SectionTitle("Today's Care"),
                _task(Icons.check_circle, const Color(0xFF4CAF50), 'Water: ${plant.waterLevel}'),
                _task(Icons.local_florist, const Color(0xFFFB8C00),
                    plant.fertilizerNote.isEmpty ? 'No fertilizer note yet' : 'Fertilize: ${plant.fertilizerNote}'),
                _task(Icons.photo_camera_outlined, const Color(0xFF5C6BC0), 'Last scan: ${relativeDay(plant.lastScan)}'),
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