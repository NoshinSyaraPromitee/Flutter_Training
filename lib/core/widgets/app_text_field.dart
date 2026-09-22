import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A rounded, filled text field matching the app's form styling —
/// used across auth, add-plant, and checkout forms.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.icon,
    this.obscure = false,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.suffix,
  });

  final TextEditingController? controller;
  final String? hint;
  final IconData? icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        maxLines: obscure ? 1 : maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textSecondary),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          prefixIcon: icon == null ? null : Icon(icon, color: AppColors.green),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
