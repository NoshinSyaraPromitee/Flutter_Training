import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/gradient_background.dart';

/// Launch/loading screen shown while the app initializes.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            Positioned(
              left: -40,
              top: -20,
              width: 130,
              child: Opacity(
                opacity: 0.9,
                child: Image.asset('assets/images/corner_flowers.png'),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  children: [
                    Text(
                      'MyPlantPal',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heroTitle,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 220,
                      child: Image.asset('assets/images/splash_mascot.png'),
                    ),
                    const SizedBox(height: 48),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const LinearProgressIndicator(
                        minHeight: 4,
                        backgroundColor: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Loading...', style: AppTextStyles.loadingCaption),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
