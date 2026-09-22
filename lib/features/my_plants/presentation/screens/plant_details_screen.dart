import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/plant.dart';
import '../providers/my_plants_providers.dart';
import '../widgets/delete_plant_dialog.dart';
import '../widgets/health_badge.dart';
import '../widgets/plant_action_buttons.dart';
import '../widgets/plant_stats_section.dart';
import '../widgets/plant_thumb.dart';
import '../widgets/plant_todays_care_section.dart';

class PlantDetailsScreen extends ConsumerWidget {
  const PlantDetailsScreen({super.key, required this.plantId});

  final String plantId;

  Future<void> _onWater(
    BuildContext context,
    WidgetRef ref,
    Plant plant,
  ) async {
    ref.read(myPlantsProvider.notifier).markWatered(plant.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${plant.nickname} marked as watered')),
    );
  }

  Future<void> _onDelete(
    BuildContext context,
    WidgetRef ref,
    Plant plant,
  ) async {
    final ok = await showDeletePlantDialog(context, plant.nickname);
    if (ok != true) return;
    ref.read(myPlantsProvider.notifier).remove(plant.id);
    if (context.mounted) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/plants');
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plant = ref.watch(
      myPlantsProvider.select((plants) {
        for (final p in plants) {
          if (p.id == plantId) return p;
        }
        return null;
      }),
    );

    if (plant == null) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurvedHeader(
              title: 'Plant',
              color: AppColors.green,
              onBack: () => context.pop(),
            ),
            const Expanded(child: ErrorView(message: 'Plant not found.')),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: plant.nickname,
            subtitle: plant.species,
            color: AppColors.green,
            onBack: () =>
                context.canPop() ? context.pop() : context.go('/plants'),
            corner: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (v) => v == 'water'
                  ? _onWater(context, ref, plant)
                  : _onDelete(context, ref, plant),
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'water', child: Text('Mark as watered')),
                PopupMenuItem(value: 'delete', child: Text('Delete plant')),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: PlantThumb(
                      imagePath: plant.imagePath,
                      width: 140,
                      height: 140,
                      radius: AppRadius.lg,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Center(child: HealthBadge(health: plant.health)),
                  const SizedBox(height: AppSpacing.lg),
                  PlantStatsSection(plant: plant),
                  const SizedBox(height: AppSpacing.lg),
                  PlantTodaysCareSection(plant: plant),
                  const SizedBox(height: AppSpacing.md),
                  PlantActionButtons(
                    onScan: () => context.push('/scan'),
                    onRoadmap: () => context.push('/plants/new'),
                    onCareGuide: () =>
                        context.push('/care-guide?plantId=${plant.id}'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
