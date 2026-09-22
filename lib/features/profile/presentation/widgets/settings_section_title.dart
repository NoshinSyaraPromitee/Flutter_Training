import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
    child: Text(text.toUpperCase(), style: AppTextStyles.sectionLabel),
  );
}
