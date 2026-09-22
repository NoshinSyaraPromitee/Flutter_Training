import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';

/// Pre-login landing page: brand moment + "Get Started" / guest entry.
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.xxl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/Hello.gif',
                      width: 160,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'MyPlantPal',
                    style: AppTextStyles.displayLarge.copyWith(fontSize: 38),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    "Your garden's best friend",
                    style: AppTextStyles.bodyText.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    label: 'Get Started',
                    variant: AppButtonVariant.secondary,
                    trailingIcon: Icons.arrow_circle_right_outlined,
                    expand: true,
                    onPressed: () => context.go('/login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
