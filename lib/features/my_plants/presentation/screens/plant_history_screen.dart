import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/plant.dart';
import '../providers/my_plants_providers.dart';
import '../widgets/plant_thumb.dart';

class PlantHistoryScreen extends ConsumerWidget {
  const PlantHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(plantHistoryProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'Plant History',
            color: AppColors.teal,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: history.isEmpty
                  ? const EmptyView(
                      icon: Icons.history,
                      title: 'No activity yet',
                      subtitle: 'Scan or water a plant to get started!',
                    )
                  : ListView.separated(
                      itemCount: history.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, i) {
                        final entry = history[i];
                        final isScan = entry.action == HistoryAction.scan;
                        final color = isScan ? AppColors.green : AppColors.teal;
                        return AppCard(
                          onTap: () =>
                              context.push('/plants/${entry.plant.id}'),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: color,
                                child: Icon(
                                  isScan ? Icons.eco : Icons.water_drop,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              PlantThumb(
                                imagePath: entry.plant.imagePath,
                                width: 48,
                                height: 48,
                                radius: AppRadius.sm,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${isScan ? 'AI Scan' : 'Watered'} • ${entry.plant.nickname}',
                                      style: AppTextStyles.bodyText.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      entry.note,
                                      style: AppTextStyles.caption,
                                    ),
                                    Text(
                                      relativeDay(entry.date),
                                      style: AppTextStyles.caption.copyWith(
                                        color: color,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
