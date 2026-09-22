import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/fertilizer_providers.dart';

/// Shows the "add fertilizer" dialog and, on success, invalidates the
/// fertilizer list provider so the new entry appears. Returns `true` if a
/// fertilizer was created.
Future<bool?> showAddFertilizerDialog(
  BuildContext context,
  WidgetRef ref,
) async {
  final l10n = AppLocalizations.of(context);
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final instructionsController = TextEditingController();

  final created = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      title: Text(l10n.addFertilizerButton),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: l10n.fertilizerNameFieldLabel,
            ),
          ),
          TextField(
            controller: categoryController,
            decoration: InputDecoration(
              labelText: l10n.fertilizerCategoryFieldLabel,
            ),
          ),
          TextField(
            controller: instructionsController,
            decoration: InputDecoration(
              labelText: l10n.fertilizerInstructionsFieldLabel,
            ),
            maxLines: 4,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.cancelButton),
        ),
        FilledButton(
          onPressed: () async {
            if (nameController.text.trim().isEmpty ||
                instructionsController.text.trim().isEmpty)
              return;
            try {
              await ref
                  .read(fertilizerRepositoryProvider)
                  .create(
                    name: nameController.text.trim(),
                    category: categoryController.text.trim(),
                    instructions: instructionsController.text.trim(),
                  );
              if (dialogContext.mounted) Navigator.of(dialogContext).pop(true);
            } on ApiException catch (e) {
              if (dialogContext.mounted) {
                ScaffoldMessenger.of(dialogContext)
                    .showSnackBar(SnackBar(content: Text(e.message)));
              }
            }
          },
          child: Text(l10n.saveButton),
        ),
      ],
    ),
  );

  if (created == true) ref.invalidate(fertilizerListProvider);
  return created;
}
