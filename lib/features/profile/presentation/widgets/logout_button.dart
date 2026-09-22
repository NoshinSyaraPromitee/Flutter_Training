import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'logout_dialog.dart';

/// Outlined "Log Out" button used on both the profile and settings screens.
class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton.icon(
      onPressed: () => confirmLogout(context, ref),
      icon: const Icon(Icons.logout, color: AppColors.danger),
      label: const Text('Log Out', style: TextStyle(color: AppColors.danger)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        side: const BorderSide(color: AppColors.danger),
      ),
    );
  }
}
