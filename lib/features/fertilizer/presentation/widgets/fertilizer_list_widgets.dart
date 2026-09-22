import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/net_image.dart';
import 'package:plantpal/features/fertilizer/domain/entities/fertilizer.dart';

class FertilizerSearchBar extends StatelessWidget {
  const FertilizerSearchBar({super.key, required this.onChanged, required this.hint});
  final ValueChanged<String> onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greenCardFill.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(28),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.menu),
          suffixIcon: const Icon(Icons.search),
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class FertilizerRecipeCard extends StatelessWidget {
  const FertilizerRecipeCard({super.key, required this.item});
  final Fertilizer item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.greenCardFill,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/fertilizer/${item.id}'),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            NetImage(item.imageUrl, width: 64, height: 64, radius: 10),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.name, style: AppTextStyles.inter(14, w: FontWeight.w700)),
                Text(item.purpose, style: AppTextStyles.bodyText),
                Text('Nutrient: ${item.nutrient}', style: AppTextStyles.inter(11, c: AppColors.greenPrimary, w: FontWeight.w600)),
              ]),
            ),
            const Icon(Icons.chevron_right),
          ]),
        ),
      ),
    );
  }
}
