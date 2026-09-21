import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/placeholder_photo.dart';
import '../../domain/diagnosis.dart';
import '../providers/diagnosis_providers.dart';

/// "Diseases Detection" screen. There's no real camera/gallery picker yet,
/// so "Upload"/"Open Camera" both submit a placeholder photo to the real
/// /api/v1/diagnoses endpoint and render whatever the backend returns.
class AiDoctorScreen extends ConsumerStatefulWidget {
  const AiDoctorScreen({super.key});

  @override
  ConsumerState<AiDoctorScreen> createState() => _AiDoctorScreenState();
}

class _AiDoctorScreenState extends ConsumerState<AiDoctorScreen> {
  Diagnosis? _diagnosis;
  bool _isAnalyzing = false;
  String? _errorMessage;

  Future<void> _analyze() async {
    setState(() {
      _isAnalyzing = true;
      _errorMessage = null;
    });
    try {
      final diagnosis = await ref
          .read(diagnosisRepositoryProvider)
          .analyze(placeholderPlantPhotoBytes());
      if (!mounted) return;
      setState(() => _diagnosis = diagnosis);
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
    final diagnosis = _diagnosis;
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
              onBack: () => context.go('/home'),
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
                    onPressed: _isAnalyzing ? null : _analyze,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: l10n.openCameraButton,
                    leadingIcon: Icons.photo_camera_outlined,
                    variant: AppButtonVariant.outline,
                    isLoading: _isAnalyzing,
                    expand: true,
                    onPressed: _isAnalyzing ? null : _analyze,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  if (_errorMessage != null)
                    Row(
                      children: [
                        const Icon(Icons.error_outline, color: AppColors.danger, size: 18),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: AppColors.danger, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  if (diagnosis != null) ...[
                    _ResultBox(
                      icon: Icons.warning_amber_rounded,
                      text: diagnosis.issue,
                      color: AppColors.danger,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _ResultBox(
                      icon: Icons.healing_outlined,
                      text: l10n.cureLabel(diagnosis.cure),
                      color: AppColors.cure,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 15,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            diagnosis.disclaimer,
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppButton(
                            label: l10n.addToLogButton,
                            variant: AppButtonVariant.secondary,
                            leadingIcon: Icons.bookmark_add_outlined,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: AppButton(
                            label: l10n.buyFertilizerButton,
                            leadingIcon: Icons.storefront_outlined,
                            onPressed: () {},
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

class _ResultBox extends StatelessWidget {
  const _ResultBox({required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        boxShadow: AppShadows.tinted(color),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.5,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
