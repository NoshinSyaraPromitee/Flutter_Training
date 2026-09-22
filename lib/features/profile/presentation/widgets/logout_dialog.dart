import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

/// Confirms, then logs out via the real [AuthController] and returns to
/// the landing screen.
Future<void> confirmLogout(BuildContext context, WidgetRef ref) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      title: const Text('Log Out'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text(
            'Log Out',
            style: TextStyle(color: AppColors.danger),
          ),
        ),
      ],
    ),
  );
  if (confirmed != true) return;

  await ref.read(authControllerProvider.notifier).logout();
  if (context.mounted) context.go('/landing');
}
