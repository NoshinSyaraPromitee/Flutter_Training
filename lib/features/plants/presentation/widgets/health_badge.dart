import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';

class HealthBadge extends StatelessWidget {
  const HealthBadge({super.key, this.health});
  final int? health;

  @override
  Widget build(BuildContext context) {
    final h = health;
    final Color color;
    final String text;
    if (h == null) {
      color = Colors.grey;
      text = 'Not scanned yet';
    } else if (h < 60) {
      color = const Color(0xFFE53935);
      text = '$h% • Critical';
    } else if (h < 85) {
      color = const Color(0xFFFB8C00);
      text = '$h% • Needs Care';
    } else {
      color = const Color(0xFF43A047);
      text = '$h% • Healthy';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: AppTextStyles.inter(12, w: FontWeight.w700, c: Colors.white)),
    );
  }
}