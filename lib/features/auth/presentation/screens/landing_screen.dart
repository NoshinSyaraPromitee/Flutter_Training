import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/gradient_background.dart';
import 'package:plantpal/features/auth/presentation/widgets/landing_decor.dart';
import 'package:plantpal/features/auth/presentation/widgets/landing_mascot.dart';
import 'package:plantpal/l10n/app_localizations.dart';

/// First screen shown after the splash loader — same blob/mascot/fern
/// artwork as SplashScreen, with a "Get Started" call to action.
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: GradientBackground(
        child: LandingDecor(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;
              return Column(
                children: [
                  SizedBox(height: h * 0.06),
                  Text(t.landingTitle, textAlign: TextAlign.center, style: AppTextStyles.heroTitle),
                  const SizedBox(height: 10),
                  Text(
                    t.landingSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF6B5300)),
                  ),
                  const Spacer(),
                  LandingMascot(width: w * 0.85),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        label: 'Get Started',
                        trailingIcon: Icons.arrow_circle_right_outlined,
                        onPressed: () => context.go('/login'),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.08),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}