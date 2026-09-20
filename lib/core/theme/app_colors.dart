import 'package:flutter/material.dart';

/// Colors extracted from the MyPlantPal Figma design.
class AppColors {
  AppColors._();

  static const Color brownHeading = Color(0xFFB87914);
  static const Color orangeAccent = Color(0xFFBC5E0C);
  static const Color greenPrimary = Color(0xFF2F6D3E);
  static const Color greenCardFill = Color(0xFF97DD70);
  static const Color textDark = Colors.black;

  static const Color buttonGreen = Color(0xFF2F6D3E);
  static const Color buttonOrange = Color(0xFFF3A94C);

  static const Color formCardBg = Color(0xFFF0C48A);
  static const Color dangerBoxRed = Color(0xFFD95A5A);
  static const Color cureBoxGreen = Color(0xFF5DA635);

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
