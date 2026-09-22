import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/gradient_background.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/fertilizer/presentation/controllers/fertilizer_controller.dart';
import 'package:plantpal/features/fertilizer/presentation/widgets/fertilizer_list_widgets.dart';
import 'package:provider/provider.dart';

/// Fertilizer info / recipe screen.
class FertilizerScreen extends StatelessWidget {
  const FertilizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<FertilizerController>();
    final list = c.filtered;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Fertilizer Making', textAlign: TextAlign.center, style: AppTextStyles.screenTitle),
                const SizedBox(height: 12),
                Center(child: Image.asset('assets/images/fertilizer_bag.png', width: 100, height: 100)),
                const SizedBox(height: 20),
                FertilizerSearchBar(onChanged: c.setQuery, hint: 'Find your homemade fertilizer'),
                const SizedBox(height: 16),
                Expanded(
                  child: c.loading
                      ? const LoadingView()
                      : list.isEmpty
                          ? EmptyView(icon: Icons.science_outlined, title: 'No recipes found', subtitle: 'Nothing matches “${c.query}”.')
                          : ListView.separated(
                              itemCount: list.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 10),
                              itemBuilder: (_, i) => FertilizerRecipeCard(item: list[i]),
                            ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      label: 'Back',
                      variant: AppButtonVariant.green,
                      onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
                    ),
                    AppButton(label: 'Add a new Fertilizer', variant: AppButtonVariant.orange, onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
