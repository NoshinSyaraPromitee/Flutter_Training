import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({super.key, required this.value, required this.onMinus, required this.onPlus});
  final int value;
  final VoidCallback onMinus, onPlus;

  @override
  Widget build(BuildContext context) {
    Widget btn(IconData i, VoidCallback f) => InkWell(
          onTap: f,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: AppColors.surfaceGreen, borderRadius: BorderRadius.circular(10)),
            child: Icon(i, size: 18, color: AppColors.greenPrimary),
          ),
        );
    return Row(mainAxisSize: MainAxisSize.min, children: [
      btn(Icons.remove, onMinus),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text('$value', style: AppTextStyles.inter(16, w: FontWeight.w700)),
      ),
      btn(Icons.add, onPlus),
    ]);
  }
}