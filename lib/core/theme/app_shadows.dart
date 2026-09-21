import 'package:flutter/material.dart';

/// Soft neutral shadows used for cards and floating elements.
class AppShadows {
  AppShadows._();

  static List<BoxShadow> card = [
    BoxShadow(
      color: const Color(0xFF16201B).withValues(alpha: 0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> raised = [
    BoxShadow(
      color: const Color(0xFF16201B).withValues(alpha: 0.16),
      blurRadius: 28,
      offset: const Offset(0, 12),
    ),
  ];

  /// A colored shadow that matches the element casting it, for a soft glow
  /// under bold color blocks (buttons, header banners).
  static List<BoxShadow> tinted(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.35),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];
}
