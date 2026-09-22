import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';

/// Title, optional category line, "LogBook" button, and scroll-progress bar
/// pinned above the Maintenance screen's scrollable content.
class MaintenanceHeader extends StatelessWidget {
  const MaintenanceHeader({
    super.key,
    required this.category,
    required this.progress,
    required this.onLogBook,
  });

  final String? category;
  final double progress;
  final VoidCallback onLogBook;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        children: [
          Text(
            'Maintenance',
            style: GoogleFonts.baloo2(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppColors.orangeAccent,
            ),
          ),
          if (category != null) ...[
            const SizedBox(height: 2),
            Text(
              'Category: $category',
              style: AppTextStyles.inter(
                13,
                w: FontWeight.w700,
                c: AppColors.greenPrimary,
              ),
            ),
          ],
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onLogBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('LogBook of my Plants'),
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.black12,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF6C63FF)),
            ),
          ),
        ],
      ),
    );
  }
}
