import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_card.dart';

/// Static care tips, lightly personalized with the plant's name.
class MaintenanceTipsSection extends StatelessWidget {
  const MaintenanceTipsSection({super.key, this.sectionKey, required this.plantName});

  final Key? sectionKey;
  final String plantName;

  @override
  Widget build(BuildContext context) {
    final name = plantName.trim().isEmpty ? 'your plant' : plantName.trim();
    return Column(
      key: sectionKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle('Tips'),
        _tip("Keep $name in the sun for 100 minutes, it's sunny today."),
        const SizedBox(height: 10),
        _tip("Water 500ml — it's a warm day."),
      ],
    );
  }

  Widget _tip(String text) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: const Color(0xFFF3E3C8), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            const Icon(Icons.lightbulb_outline, color: AppColors.sunAmber),
            const SizedBox(width: 10),
            Expanded(child: Text(text, style: AppTextStyles.inter(13, h: 1.4))),
          ],
        ),
      );
}