import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Confirmation dialog shown before deleting a plant; resolves `true` if the
/// user confirmed.
Future<bool?> showDeletePlantDialog(BuildContext context, String nickname) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete plant?'),
      content: Text('$nickname will be removed from your collection.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text(
            'Delete',
            style: TextStyle(color: AppColors.danger),
          ),
        ),
      ],
    ),
  );
}
