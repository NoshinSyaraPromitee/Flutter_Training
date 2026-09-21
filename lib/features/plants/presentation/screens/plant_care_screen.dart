import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/plant.dart';
import '../providers/plant_providers.dart';

/// Plant registration form ("Maintainance") that, on submit, calls the
/// backend and shows the generated care roadmap in place — mirroring the
/// Figma flow from the "maintenance" frame to the "Maintenance_2" frame.
class PlantCareScreen extends ConsumerStatefulWidget {
  const PlantCareScreen({super.key});

  @override
  ConsumerState<PlantCareScreen> createState() => _PlantCareScreenState();
}

class _PlantCareScreenState extends ConsumerState<PlantCareScreen> {
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _ageController = TextEditingController();

  Plant? _plant;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _createRoadmap() async {
    if (_nameController.text.trim().isEmpty) return;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      final plant = await ref
          .read(plantRepositoryProvider)
          .create(
            name: _nameController.text.trim(),
            type: _typeController.text.trim(),
            ageStage: _ageController.text.trim(),
          );
      if (!mounted) return;
      setState(() => _plant = plant);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
    } catch (_) {
      if (!mounted) return;
      setState(
        () => _errorMessage = AppLocalizations.of(context).serverUnreachable,
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final plant = _plant;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurvedHeader(
              title: l10n.maintainance,
              subtitle: plant == null
                  ? l10n.maintainanceHeaderSubtitleForm
                  : l10n.maintainanceHeaderSubtitleResult,
              color: AppColors.green,
              onBack: () => context.go('/home'),
              corner: const LanguageSwitcher(),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: plant == null
                  ? _PlantCareForm(
                      nameController: _nameController,
                      typeController: _typeController,
                      ageController: _ageController,
                      isSubmitting: _isSubmitting,
                      errorMessage: _errorMessage,
                      onSubmit: _createRoadmap,
                    )
                  : _CareRoadmapView(
                      plantName: plant.name,
                      roadmap: plant.careRoadmap,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlantCareForm extends StatelessWidget {
  const _PlantCareForm({
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
          _FieldLabel(l10n.nameOfPlantLabel),
          _FormTextField(
            controller: nameController,
            hint: l10n.nameFieldHint,
            icon: Icons.eco_outlined,
          ),
          const SizedBox(height: AppSpacing.lg),
          _FieldLabel(l10n.typesOfPlantLabel),
          _FormTextField(
            controller: typeController,
            hint: l10n.typesFieldHint,
            icon: Icons.category_outlined,
          ),
          const SizedBox(height: AppSpacing.lg),
          _FieldLabel(l10n.plantAgeLabel),
          _FormTextField(
            controller: ageController,
            hint: l10n.ageFieldHint,
            icon: Icons.hourglass_bottom_outlined,
            maxLines: 3,
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                const Icon(Icons.error_outline, color: AppColors.danger, size: 18),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: AppColors.danger, fontSize: 13),
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(text, style: AppTextStyles.titleMedium.copyWith(fontSize: 14)),
    );
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: AppTextStyles.bodyText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyText.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: Icon(icon, color: AppColors.green, size: 20),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _CareRoadmapView extends StatelessWidget {
  const _CareRoadmapView({required this.plantName, required this.roadmap});

  final String plantName;
  final CareRoadmap roadmap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.water_drop, color: Colors.white),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  l10n.yourPlantNeeds(plantName, roadmap.waterAmountMl),
                  style: AppTextStyles.bodyText.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final time in roadmap.wateringTimes) _TimeChip(label: time),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: l10n.setAlarmButton,
          leadingIcon: Icons.alarm,
          expand: true,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.xl),
        _InfoBox(
          icon: Icons.lightbulb_outline,
          text: l10n.tipsLabel(roadmap.tips),
          color: AppColors.teal,
        ),
        const SizedBox(height: AppSpacing.md),
        _InfoBox(
          icon: Icons.spa_outlined,
          text: roadmap.fertilizerRecommendation,
          color: AppColors.orange,
        ),
      ],
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.schedule, size: 16, color: Colors.white),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.icon, required this.text, required this.color});
  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: color.withValues(alpha: 0.1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(text, style: AppTextStyles.bodyText)),
        ],
      ),
    );
  }
}
