import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/plant.dart';
import '../providers/my_plants_providers.dart';

class CareCalendarScreen extends ConsumerStatefulWidget {
  const CareCalendarScreen({super.key});

  @override
  ConsumerState<CareCalendarScreen> createState() => _CareCalendarScreenState();
}

class _CareCalendarScreenState extends ConsumerState<CareCalendarScreen> {
  final _done = <String>{};

  static const _titles = {
    CareTaskGroup.today: 'Today',
    CareTaskGroup.tomorrow: 'Tomorrow',
    CareTaskGroup.later: 'Later This Week',
  };

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(careTasksProvider);
    final allDone =
        tasks.isNotEmpty && tasks.every((t) => _done.contains(t.id));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'Care Calendar',
            color: AppColors.orange,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: tasks.isEmpty
                  ? const EmptyView(
                      icon: Icons.event_available_outlined,
                      title: 'No care tasks yet',
                      subtitle: 'Add a plant to see its watering schedule.',
                    )
                  : ListView(
                      children: [
                        for (final group in CareTaskGroup.values)
                          if (tasks.any((t) => t.group == group)) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.sm,
                              ),
                              child: Text(
                                _titles[group]!.toUpperCase(),
                                style: AppTextStyles.sectionLabel,
                              ),
                            ),
                            for (final task in tasks.where(
                              (t) => t.group == group,
                            ))
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.sm,
                                ),
                                child: AppCard(
                                  onTap: () => setState(
                                    () => _done.contains(task.id)
                                        ? _done.remove(task.id)
                                        : _done.add(task.id),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.teal
                                            .withValues(alpha: 0.15),
                                        child: Icon(
                                          Icons.water_drop,
                                          color: AppColors.teal,
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Water ${task.plant.nickname}',
                                              style: AppTextStyles.bodyText
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Text(
                                              '${task.plant.species} • ${task.plant.location.isEmpty ? '—' : task.plant.location}',
                                              style: AppTextStyles.caption,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        _done.contains(task.id)
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color: _done.contains(task.id)
                                            ? AppColors.green
                                            : AppColors.textSecondary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        if (allDone)
                          const Padding(
                            padding: EdgeInsets.only(top: AppSpacing.xl),
                            child: EmptyView(
                              icon: Icons.verified_outlined,
                              title: 'All caught up!',
                              subtitle: 'Your plants thank you.',
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
