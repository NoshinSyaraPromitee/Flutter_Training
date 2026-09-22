import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/features/auth/presentation/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

Future<void> confirmLogout(BuildContext context) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Log Out'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Log Out', style: TextStyle(color: AppColors.danger))),
      ],
    ),
  );
  if (ok != true || !context.mounted) return;
  await context.read<AuthController>().logout();
  if (context.mounted) context.go('/landing');
}