import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/gradient_background.dart';

/// Fertilizer info / recipe screen.
class FertilizerScreen extends StatelessWidget {
  const FertilizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Fertilizer Making',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.screenTitle,
                ),
                const SizedBox(height: 12),
                Center(
                  child: Image.asset(
                    'assets/images/fertilizer_bag.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                const _FertilizerSearchBar(),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.greenCardFill,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Nitrogen(leaf growth):\n'
                    '•Put 1 banana peel + used tea leaves + 1 liter water '
                    'in a bottle/jar. Keep it in a shady, cool place (not '
                    'under direct sun).\n'
                    '•Soak for 2 days.\n'
                    '•Then pour a little around the soil near the roots, '
                    'not directly on the trunk.\n'
                    '•Use it once every 10–15 days.',
                    style: AppTextStyles.bodyText,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      label: 'Back',
                      variant: AppButtonVariant.green,
                      onPressed: () => context.go('/home'),
                    ),
                    AppButton(
                      label: 'Add a new Fertilizer',
                      variant: AppButtonVariant.orange,
                      onPressed: () {},
                    ),
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

class _FertilizerSearchBar extends StatelessWidget {
  const _FertilizerSearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greenCardFill.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(28),
      ),
      child: const TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.menu),
          suffixIcon: Icon(Icons.search),
          hintText: 'Find your homemade fertilizer',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
