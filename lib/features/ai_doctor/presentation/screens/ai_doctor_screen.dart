import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../domain/diagnosis_result.dart';

/// "Diseases Detection" screen. Uploading/capturing a photo is mocked —
/// either action reveals a static diagnosis result matching the Figma
/// design, since this screen is UI-only for now.
class AiDoctorScreen extends StatefulWidget {
  const AiDoctorScreen({super.key});

  @override
  State<AiDoctorScreen> createState() => _AiDoctorScreenState();
}

class _AiDoctorScreenState extends State<AiDoctorScreen> {
  bool _hasResult = false;

  @override
  Widget build(BuildContext context) {
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
                  label: "Upload your Plant's Photo",
                  trailingIcon: Icons.add_circle_outline,
                  onPressed: () => setState(() => _hasResult = true),
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Open Camera to take photo',
                  trailingIcon: Icons.add_circle_outline,
                  onPressed: () => setState(() => _hasResult = true),
                ),
                const SizedBox(height: 24),
                if (_hasResult) ...[
                  _ResultBox(
                    text: mockDiagnosisResult.issue,
                    color: AppColors.dangerBoxRed,
                  ),
                  const SizedBox(height: 16),
                  _ResultBox(
                    text: 'cure : ${mockDiagnosisResult.cure}',
                    color: AppColors.cureBoxGreen,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    diagnosisDisclaimer,
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
