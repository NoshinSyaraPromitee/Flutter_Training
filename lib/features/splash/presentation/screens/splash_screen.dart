import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../widgets/splash_decor.dart';

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;

            return Stack(
              children: [
                SplashDecor(width: w, height: h),
                SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: h * 0.06),
                      Text('PlantPal', textAlign: TextAlign.center, style: AppTextStyles.heroTitle),
                      const SizedBox(height: 10),
                      const Text(
                        "Your Garden's best Friend",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF6B5300)),
                      ),
                      const Spacer(),
                      SplashMascot(width: w * 0.85),
                      const Spacer(),
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
                      Text('Loading...', style: AppTextStyles.loadingCaption),
                      SizedBox(height: h * 0.08),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
