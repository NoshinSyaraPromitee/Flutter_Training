import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
<<<<<<< Updated upstream

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/generated/app_localizations.dart';
=======
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/gradient_background.dart';
import 'package:plantpal/l10n/app_localizations.dart';
>>>>>>> Stashed changes

/// Launch/loading screen shown while the app initializes.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final _fade = CurvedAnimation(parent: _entrance, curve: Curves.easeOut);
  late final _scale = Tween(
    begin: 0.92,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _entrance, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    _entrance.forward();
    Timer(const Duration(seconds: 2), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.green,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.eco, color: Colors.white, size: 40),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    AppLocalizations.of(context).appTitle,
                    style: AppTextStyles.displayLarge.copyWith(fontSize: 38),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    AppLocalizations.of(context).splashTagline,
                    style: AppTextStyles.bodyText.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
<<<<<<< Updated upstream
                  const SizedBox(height: AppSpacing.xxl),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/splash_mascot.png',
                      width: 140,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  SizedBox(
                    width: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        minHeight: 6,
                        backgroundColor: Colors.white.withValues(alpha: 0.25),
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.orange,
                        ),
                      ),
=======
                ),

                // Small fern above the loading bar
                Positioned(
                  left: w * 0.53,
                  top: h * 0.735,
                  width: w * 0.10,
                  child: Image.asset('assets/images/fern.png'),
                ),

                // Large fern, bottom right
                Positioned(
                  right: w * 0.05,
                  bottom: 0,
                  width: w * 0.20,
                  child: Image.asset('assets/images/fern.png'),
                ),

                // Main content
                Positioned.fill(
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.06),
                        Text(
                          'PlantPal',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heroTitle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.appTagline,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF5A4300),
                          ),
                        ),
                        const Spacer(),

                        // Big blob with the mascot on top
                        SizedBox(
                          width: w * 0.85,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/blob1.png',
                                width: w * 0.85,
                                fit: BoxFit.contain,
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: const Alignment(0.1, 0.35),
                                  child: SizedBox(
                                    width: w * 0.45,
                                    child: Image.asset(
                                      'assets/images/splash_mascot.png',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Loading bar + caption
                        SizedBox(
                          width: w * 0.42,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: const LinearProgressIndicator(
                              minHeight: 3,
                              color: Color(0xFFDDB54A),
                              backgroundColor: Color(0xFFE9E4B4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(l10n.loadingLabel, style: AppTextStyles.loadingCaption),
                        SizedBox(height: h * 0.08),
                      ],
>>>>>>> Stashed changes
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
