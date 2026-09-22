import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'field_label.dart';
import 'form_text_field.dart';

class PlantCareForm extends StatelessWidget {
  const PlantCareForm({
    super.key,
    required this.nameController,
    required this.typeController,
    required this.ageController,
    required this.isSubmitting,
    required this.errorMessage,
    required this.onSubmit,
  });

  final TextEditingController nameController;
  final TextEditingController typeController;
  final TextEditingController ageController;
  final bool isSubmitting;
  final String? errorMessage;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FieldLabel(l10n.nameOfPlantLabel),
          FormTextField(
            controller: nameController,
            hint: l10n.nameFieldHint,
            icon: Icons.eco_outlined,
          ),
          const SizedBox(height: AppSpacing.lg),
          FieldLabel(l10n.typesOfPlantLabel),
          FormTextField(
            controller: typeController,
            hint: l10n.typesFieldHint,
            icon: Icons.category_outlined,
          ),
          const SizedBox(height: AppSpacing.lg),
          FieldLabel(l10n.plantAgeLabel),
          FormTextField(
            controller: ageController,
            hint: l10n.ageFieldHint,
            icon: Icons.hourglass_bottom_outlined,
            maxLines: 3,
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.danger,
                  size: 18,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: AppColors.danger,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: l10n.createRoadmapButton,
            variant: AppButtonVariant.secondary,
            isLoading: isSubmitting,
            expand: true,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}
