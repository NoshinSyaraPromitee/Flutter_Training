import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/plant.dart';
import '../providers/plant_providers.dart';
import '../widgets/care_roadmap_view.dart';
import '../widgets/plant_care_form.dart';

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
                  ? PlantCareForm(
                      nameController: _nameController,
                      typeController: _typeController,
                      ageController: _ageController,
                      isSubmitting: _isSubmitting,
                      errorMessage: _errorMessage,
                      onSubmit: _createRoadmap,
                    )
                  : CareRoadmapView(
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
