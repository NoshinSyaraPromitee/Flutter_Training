import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';

/// "Upload your Plant's Photo" call-to-action button on the main menu.
class MainMenuUploadButton extends StatelessWidget {
  const MainMenuUploadButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF718355),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFF7BC65A), width: 1.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: AppTextStyles.inter(16, c: Colors.white)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_circle_right_outlined, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
