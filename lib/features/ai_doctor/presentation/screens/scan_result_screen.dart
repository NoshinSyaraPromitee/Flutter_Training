import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/ai_doctor/presentation/controllers/scan_controller.dart';
import 'package:plantpal/features/ai_doctor/presentation/widgets/diagnosis_card.dart';
import 'package:plantpal/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scan = context.watch<ScanController>();
    final r = scan.result;
    return AppScreen(
      title: l10n.plantIdentifiedTitle,
      child: r == null
          ? EmptyView(icon: Icons.photo_camera, title: l10n.noScanResultTitle, subtitle: l10n.noScanResultBody)
          : ListView(padding: const EdgeInsets.only(bottom: 32), children: [
              if (scan.imagePath != null)
                ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.file(File(scan.imagePath!), height: 220, fit: BoxFit.cover)),
              const SizedBox(height: 14),
              AppCard(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r.plantName ?? l10n.unknownPlantLabel, style: AppTextStyles.inter(22, w: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(r.text, style: AppTextStyles.inter(14, h: 1.4)),
                  if (r.diagnosis != null) DiagnosisCard(diagnosis: r.diagnosis!),
                ]),
              ),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: AppButton(label: l10n.viewCareGuideButton, trailingIcon: Icons.eco, onPressed: () => context.push('/care-guide'))),
              const SizedBox(height: 10),
              SizedBox(width: double.infinity, child: AppButton(label: l10n.askAiDoctorButton, variant: AppButtonVariant.orange, trailingIcon: Icons.smart_toy, onPressed: () => context.go('/ai-doctor'))),
            ]),
    );
  }
}