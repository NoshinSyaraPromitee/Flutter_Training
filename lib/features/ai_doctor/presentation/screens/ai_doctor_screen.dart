import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/gradient_background.dart';
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
        () => _errorMessage = 'Could not reach the server. Is the backend running?',
      );
    } finally {
      if (mounted) setState(() => _isAnalyzing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final diagnosis = _diagnosis;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Diseases Detection',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.screenTitle,
                ),
                const SizedBox(height: 12),
                Center(
                  child: Image.asset(
                    'assets/images/disease_plant.png',
                    width: 150,
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: _isAnalyzing
                      ? 'Analyzing...'
                      : "Upload your Plant's Photo",
                  trailingIcon: Icons.add_circle_outline,
                  onPressed: _isAnalyzing ? null : _analyze,
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: _isAnalyzing
                      ? 'Analyzing...'
                      : 'Open Camera to take photo',
                  trailingIcon: Icons.add_circle_outline,
                  onPressed: _isAnalyzing ? null : _analyze,
                ),
                const SizedBox(height: 24),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                if (diagnosis != null) ...[
                  _ResultBox(
                    text: diagnosis.issue,
                    color: AppColors.dangerBoxRed,
                  ),
                  const SizedBox(height: 16),
                  _ResultBox(
                    text: 'cure : ${diagnosis.cure}',
                    color: AppColors.cureBoxGreen,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    diagnosis.disclaimer,
                    style: AppTextStyles.bodyText.copyWith(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(
                        label: 'Add to Log',
                        variant: AppButtonVariant.orange,
                        onPressed: () {},
                      ),
                      AppButton(label: 'Buy Fertilizer', onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                Align(
                  alignment: Alignment.centerRight,
                  child: AppButton(
                    label: 'Back',
                    onPressed: () => context.go('/home'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultBox extends StatelessWidget {
  const _ResultBox({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          height: 1.4,
        ),
      ),
    );
  }
}
