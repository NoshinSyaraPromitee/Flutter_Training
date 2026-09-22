import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/photo_picker.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/diagnosis_providers.dart';

/// "Diseases Detection" entry screen (bottom tab, route `/scan`): pick a
/// real photo, submit it to the backend, then push the result screen.
class ScanPlantScreen extends ConsumerStatefulWidget {
  const ScanPlantScreen({super.key});

  @override
  ConsumerState<ScanPlantScreen> createState() => _ScanPlantScreenState();
}

class _ScanPlantScreenState extends ConsumerState<ScanPlantScreen> {
  bool _isAnalyzing = false;
  String? _errorMessage;

  Future<void> _scan(ImageSource source) async {
    final path = await pickPhoto(context, source: source);
    if (path == null) return; // user cancelled

    setState(() {
      _isAnalyzing = true;
      _errorMessage = null;
    });
    try {
      final bytes = await File(path).readAsBytes();
      final diagnosis = await ref
          .read(diagnosisRepositoryProvider)
          .analyze(bytes);
      if (!mounted) return;
      context.push('/scan-result', extra: diagnosis);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
    } catch (_) {
      if (!mounted) return;
      setState(
        () => _errorMessage = AppLocalizations.of(context).serverUnreachable,
      );
    } finally {
      if (mounted) setState(() => _isAnalyzing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurvedHeader(
              title: l10n.diseasesDetectionHeader,
              subtitle: l10n.diseasesDetectionSubtitle,
              color: AppColors.teal,
              corner: const LanguageSwitcher(),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    label: l10n.uploadPlantPhoto,
                    leadingIcon: Icons.upload_file_outlined,
                    isLoading: _isAnalyzing,
                    expand: true,
                    onPressed: _isAnalyzing
                        ? null
                        : () => _scan(ImageSource.gallery),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: l10n.openCameraButton,
                    leadingIcon: Icons.photo_camera_outlined,
                    variant: AppButtonVariant.outline,
                    isLoading: _isAnalyzing,
                    expand: true,
                    onPressed: _isAnalyzing
                        ? null
                        : () => _scan(ImageSource.camera),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: AppSpacing.xl),
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
                            _errorMessage!,
                            style: const TextStyle(
                              color: AppColors.danger,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
