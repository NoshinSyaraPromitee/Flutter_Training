import "package:flutter/material.dart";
import "package:plantpal/core/theme/app_colors.dart";
import "package:plantpal/core/theme/app_text_styles.dart";
import "package:plantpal/core/widgets/app_text_field.dart";

/// Label + input pair used by [AddFertilizerScreen]. Pulled out of the
/// screen file so the form body stays declarative and short.
class FertilizerFormSection extends StatelessWidget {
  const FertilizerFormSection({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6, top: 14),
            child: Text(label, style: AppTextStyles.inter(15, w: FontWeight.w700, c: AppColors.greenPrimary)),
          ),
          AppTextField(controller: controller, hint: hint, maxLines: maxLines),
        ],
      );
}
