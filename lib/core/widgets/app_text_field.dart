import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_colors.dart';

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
    this.radius = 15,
  });

  final TextEditingController? controller;
  final String? hint;
  final IconData? icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(radius)),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          maxLines: obscure ? 1 : maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            prefixIcon: icon == null ? null : Icon(icon, color: AppColors.greenPrimary),
            suffixIcon: suffix,
          ),
        ),
      );
}