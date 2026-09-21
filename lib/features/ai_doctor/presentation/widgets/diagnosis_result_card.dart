import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/diagnosis.dart';

/// Shows a completed [Diagnosis]: the detected issue, the suggested cure,
/// and the backend's disclaimer.
///
/// Deliberately has no severity badge or confidence percentage. The backend
/// contract carries neither, and inventing them on the client would mean
/// showing the user a number the system never actually computed. Add them
/// here once the real Gemini/Groq provider can produce them and the Go
/// entity carries them.
class DiagnosisResultCard extends StatelessWidget {
  const DiagnosisResultCard({super.key, required this.diagnosis});

  final Diagnosis diagnosis;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.greenPrimary.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.eco_outlined,
                size: 20,
                color: AppColors.greenPrimary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Diagnosis',
                  style: AppTextStyles.screenTitle.copyWith(fontSize: 24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _Section(title: 'What we found', body: diagnosis.issue),
          const SizedBox(height: 12),
          _Section(title: 'Suggested cure', body: diagnosis.cure),
          const SizedBox(height: 14),
          Text(
            'Logged ${_formatTimestamp(diagnosis.createdAt)}',
            style: AppTextStyles.loadingCaption,
          ),
          if (diagnosis.disclaimer.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              diagnosis.disclaimer,
              style: AppTextStyles.bodyText.copyWith(
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Plain `dd/MM/yyyy HH:mm`. Deliberately not using `intl` — one
  /// timestamp isn't worth another dependency, and localized formatting is
  /// a decision for the whole app rather than this card.
  String _formatTimestamp(DateTime at) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(at.day)}/${two(at.month)}/${at.year} '
        '${two(at.hour)}:${two(at.minute)}';
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(body, style: AppTextStyles.bodyText),
      ],
    );
  }
}
