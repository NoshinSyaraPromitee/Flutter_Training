import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/state_views.dart';
import '../providers/my_plants_providers.dart';
import '../widgets/plant_status_card.dart';

class MyPlantsScreen extends ConsumerWidget {
  const MyPlantsScreen({super.key});

  Widget _stat(String value, String label) {
    return Expanded(
      child: AppCard(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.titleLarge.copyWith(color: AppColors.green),
            ),
            Text(label, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plants = ref.watch(myPlantsProvider);
    final controller = ref.read(myPlantsProvider.notifier);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'My Plants',
            subtitle: 'Your green family, all in one place.',
            color: AppColors.green,
            onBack: () =>
                context.canPop() ? context.pop() : context.go('/home'),
            corner: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.add, color: AppColors.green),
              ),
              onPressed: () => context.push('/plants/add'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: plants.isEmpty
                  ? const EmptyView(
                      icon: Icons.local_florist_outlined,
                      title: 'No plants yet',
                      subtitle: 'Tap + above to add your first plant.',
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            _stat('${plants.length}', 'Plants'),
                            const SizedBox(width: AppSpacing.sm),
                            _stat('${controller.averageHealth}%', 'Health'),
                            const SizedBox(width: AppSpacing.sm),
                            _stat(
                              '${controller.waterTodayCount}',
                              'Water Today',
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Expanded(
                          child: ListView.separated(
                            itemCount: plants.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: AppSpacing.md),
                            itemBuilder: (context, i) =>
                                PlantStatusCard(plant: plants[i]),
                          ),
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
