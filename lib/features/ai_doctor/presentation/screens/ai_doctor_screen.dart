import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../domain/failures/diagnosis_failure.dart';
import '../providers/diagnosis_provider.dart';
import '../widgets/diagnosis_result_card.dart';

/// Lets the user take or pick a photo of a plant, sends it to the Go
/// backend's `POST /api/v1/diagnoses`, and shows the result.
class AiDoctorScreen extends ConsumerStatefulWidget {
  const AiDoctorScreen({super.key});

  @override
  ConsumerState<AiDoctorScreen> createState() => _AiDoctorScreenState();
}

class _AiDoctorScreenState extends ConsumerState<AiDoctorScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        // Also keeps the base64 payload to a sane size — a full-resolution
        // phone photo inflates by roughly a third once encoded.
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked == null) return; // user backed out of the picker

      final bytes = await picked.readAsBytes();
      if (!mounted) return;

      ref.read(selectedPlantImageProvider.notifier).state = bytes;
      ref.read(diagnosisProvider.notifier).reset();
    } catch (e) {
      if (!mounted) return;
      final sourceLabel = source == ImageSource.camera ? 'camera' : 'gallery';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Couldn't open the $sourceLabel: $e")),
      );
    }
  }

  Future<void> _analyze() async {
    final bytes = ref.read(selectedPlantImageProvider);
    if (bytes == null) return;
    await ref.read(diagnosisProvider.notifier).diagnose(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final selectedImage = ref.watch(selectedPlantImageProvider);
    final diagnosisState = ref.watch(diagnosisProvider);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'AI Doctor',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.screenTitle,
                ),
                const SizedBox(height: 4),
                Text(
                  'Photograph a plant and get instant care guidance.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyText,
                ),
                const SizedBox(height: 16),
                _PhotoPreview(previewBytes: selectedImage),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton(
                      label: 'Take Photo',
                      trailingIcon: Icons.camera_alt_outlined,
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                    AppButton(
                      label: 'Choose from Gallery',
                      variant: AppButtonVariant.orange,
                      trailingIcon: Icons.photo_library_outlined,
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                  ],
                ),
                if (selectedImage != null) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: AppButton(
                      label: diagnosisState.isLoading
                          ? 'Analyzing...'
                          : 'Analyze Plant',
                      variant: AppButtonVariant.orange,
                      onPressed: diagnosisState.isLoading ? null : _analyze,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                diagnosisState.when(
                  data: (diagnosis) => diagnosis == null
                      ? const SizedBox.shrink()
                      : DiagnosisResultCard(diagnosis: diagnosis),
                  loading: () => Center(
                    child: Column(
                      children: [
                        const CircularProgressIndicator(
                          color: AppColors.greenPrimary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Analyzing your plant...',
                          style: AppTextStyles.loadingCaption,
                        ),
                      ],
                    ),
                  ),
                  error: (error, stackTrace) => _ErrorPanel(
                    // Repositories throw DiagnosisFailure, whose message is
                    // written to be shown. Anything else is a bug, so don't
                    // dump it on the user.
                    message: error is DiagnosisFailure
                        ? error.message
                        : "Couldn't analyze that photo. Please try again.",
                    onRetry: _analyze,
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(label: 'Back', onPressed: () => context.go('/home')),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: AppTextStyles.bodyText),
          const SizedBox(height: 8),
          AppButton(label: 'Try Again', onPressed: onRetry),
        ],
      ),
    );
  }
}

class _PhotoPreview extends StatelessWidget {
  const _PhotoPreview({required this.previewBytes});

  final Uint8List? previewBytes;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greenCardFill.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: previewBytes != null
          ? Image.memory(previewBytes!, fit: BoxFit.cover)
          : Center(
              child: Image.asset(
                'assets/images/disease_plant.png',
                width: 120,
                height: 120,
              ),
            ),
    );
  }
}
