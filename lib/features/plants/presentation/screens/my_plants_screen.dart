import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/app_text_field.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/plants/presentation/providers/plants_provider.dart';
import 'package:plantpal/features/plants/presentation/widgets/plant_status_card.dart';
import 'package:provider/provider.dart';

class MyPlantsScreen extends StatefulWidget {
  const MyPlantsScreen({super.key});
  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  String _q = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<PlantsController>().load());
  }

  Widget _stat(String value, String label) => Expanded(
        child: AppCard(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(children: [
            Text(value, style: AppTextStyles.inter(22, w: FontWeight.w700, c: AppColors.greenPrimary)),
            Text(label, style: AppTextStyles.inter(12, c: AppColors.textMuted)),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final c = context.watch<PlantsController>();
    final q = _q.toLowerCase().trim();
    final list = c.plants
        .where((p) => q.isEmpty || p.nickname.toLowerCase().contains(q) || p.species.toLowerCase().contains(q))
        .toList();

    return AppScreen(
      title: 'My Green Family',
      trailing: IconButton(
        icon: const CircleAvatar(backgroundColor: AppColors.greenPrimary, child: Icon(Icons.add, color: Colors.white)),
        onPressed: () => context.push('/plants/add'),
      ),
      child: c.loading && c.plants.isEmpty
          ? const LoadingView()
          : c.error != null && c.plants.isEmpty
              ? ErrorView(message: c.error!, onRetry: () => c.load(force: true))
              : Column(children: [
                  const SizedBox(height: 8),
                  AppTextField(hint: 'Search plants...', icon: Icons.search, radius: 18, onChanged: (v) => setState(() => _q = v)),
                  const SizedBox(height: 14),
                  Row(children: [
                    _stat('${c.plants.length}', 'Plants'),
                    _stat('${c.averageHealth}%', 'Health'),
                    _stat('${c.waterTodayCount}', 'Water Today'),
                  ]),
                  const SizedBox(height: 14),
                  Expanded(
                    child: list.isEmpty
                        ? const EmptyView(icon: Icons.local_florist, title: 'No plants yet', subtitle: 'Tap + to add your first plant.')
                        : RefreshIndicator(
                            onRefresh: () => c.load(force: true),
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 24),
                              itemCount: list.length,
                              itemBuilder: (_, i) => PlantStatusCard(plant: list[i]),
                            ),
                          ),
                  ),
                ]),
    );
  }
}