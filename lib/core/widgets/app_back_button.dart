import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';

/// Pops the current route if there's something to pop back to, otherwise
/// falls back to [fallback] — so it's never a dead end.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.fallback = '/home', this.color, this.circleBackground = false});

  final String fallback;
  final Color? color;
  final bool circleBackground;

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      icon: Icon(Icons.arrow_back, color: color ?? AppColors.greenPrimary),
      onPressed: () => context.canPop() ? context.pop() : context.go(fallback),
    );
    return circleBackground ? CircleAvatar(backgroundColor: Colors.white, child: button) : button;
  }
}