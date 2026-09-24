import 'package:flutter/material.dart';

/// Colors extracted from the PlantPal Figma design.
class AppColors {
  AppColors._();

  static const Color brownHeading = Color(0xFFB87914);
  static const Color orangeAccent = Color(0xFFBC5E0C);
  static const Color greenPrimary = Color(0xFF2F6D3E);
  static const Color greenCardFill = Color(0xFF97DD70);
  static const Color textDark = Colors.black;

  static const Color buttonGreen = Color(0xFF2F6D3E);
  static const Color buttonOrange = Color(0xFFF3A94C);

  static const Color textMuted = Color(0xFF7A7A7A);
  static const Color danger = Color(0xFFE53935);
  static const Color star = Color(0xFFFFD54F);
  static const Color waterBlue = Color(0xFF42A5F5);
  static const Color sunAmber = Color(0xFFFFB300);
  static const Color surfaceGreen = Color(0xFFE8F5E9);

  static const List<double> backgroundGradientStops = [
    0.0296,
    0.1565,
    0.8416,
    1.0,
  ];

  static const List<Color> backgroundGradientColors = [
    Color(0xFFFBBB6C),
    Color(0xFFDEF0D6),
    Color(0xFFC8FFA9),
    Color(0xFFFFB565),
  ];

  static const LinearGradient screenBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: backgroundGradientStops,
    colors: backgroundGradientColors,
  );
}