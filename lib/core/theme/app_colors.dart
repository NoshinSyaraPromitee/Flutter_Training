import 'package:flutter/material.dart';

/// A bold, vivid palette for MyPlantPal — a small set of saturated brand
/// colors used as confident color blocks (headers, cards, buttons) against
/// a neutral, mostly-white canvas, rather than a continuous pastel wash.
class AppColors {
  AppColors._();

  // Brand
  static const Color green = Color(0xFF1DAA5C);
  static const Color greenDark = Color(0xFF0E7A3E);
  static const Color orange = Color(0xFFFF7A1A);
  static const Color orangeDark = Color(0xFFD9600A);
  static const Color teal = Color(0xFF0E9C93);
  static const Color plum = Color(0xFFB4489B);

  // Semantic
  static const Color danger = Color(0xFFE0483C);
  static const Color cure = Color(0xFF1DAA5C);

  // Neutrals
  static const Color background = Color(0xFFF6F5F1);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF16201B);
  static const Color textSecondary = Color(0xFF6B7368);
  static const Color divider = Color(0x1416201B);

  /// Rotating accent palette for category chips / multi-item lists.
  static const List<Color> accentRotation = [green, orange, teal, plum];
}
