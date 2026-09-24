import 'package:flutter/material.dart';

/// Wraps [child] in the blob + fern background art used behind the
/// PlantPal landing/splash artwork. Mirrors SplashScreen's decoration set.
class LandingDecor extends StatelessWidget {
  const LandingDecor({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        return Stack(
          children: [
            Positioned(
              left: w * 0.03,
              top: h * 0.74,
              width: w * 0.10,
              child: Image.asset('assets/images/blob2.png'),
            ),
            Positioned(
              left: w * 0.72,
              top: h * 0.57,
              width: w * 0.09,
              child: Opacity(opacity: 0.5, child: Image.asset('assets/images/blob2.png')),
            ),
            Positioned(
              right: -w * 0.08,
              bottom: -h * 0.03,
              width: w * 0.36,
              child: Opacity(opacity: 0.55, child: Image.asset('assets/images/blob2.png')),
            ),
            Positioned(
              left: w * 0.53,
              top: h * 0.735,
              width: w * 0.10,
              child: Image.asset('assets/images/fern.png'),
            ),
            Positioned(
              right: w * 0.05,
              bottom: 0,
              width: w * 0.20,
              child: Image.asset('assets/images/fern.png'),
            ),
            SafeArea(child: child),
          ],
        );
      },
    );
  }
}