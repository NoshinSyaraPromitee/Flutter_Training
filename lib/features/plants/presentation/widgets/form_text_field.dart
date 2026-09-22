import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: AppTextStyles.bodyText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyText.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: Icon(icon, color: AppColors.green, size: 20),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
