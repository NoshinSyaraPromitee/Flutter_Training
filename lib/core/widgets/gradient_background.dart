import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.screenBackground),
          child: child,
        ),
      );
}