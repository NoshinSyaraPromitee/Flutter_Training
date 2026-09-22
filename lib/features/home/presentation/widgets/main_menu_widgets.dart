import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';

/// Outlined rounded tile with an illustration and a label underneath.
class MainMenuTile extends StatelessWidget {
  const MainMenuTile({super.key, required this.imageAsset, required this.label, required this.onTap});
  final String imageAsset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.white.withValues(alpha: 0.35),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFFB9C4B3)),
            ),
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                width: 100,
                height: 86,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(imageAsset, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.inter(13, c: const Color(0xFF6F8068)),
          ),
        ],
      ),
    );
  }
}
