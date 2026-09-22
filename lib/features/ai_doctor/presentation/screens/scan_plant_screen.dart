import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/photo_picker_sheet.dart';
import 'package:plantpal/features/ai_doctor/presentation/controllers/scan_controller.dart';
import 'package:plantpal/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ScanPlantScreen extends StatelessWidget {
  const ScanPlantScreen({super.key});

  Future<void> _scan(BuildContext context, ImageSource source) async {
    final path = await pickPhoto(context, source: source);
    if (path == null || !context.mounted) return;
    final ok = await context.read<ScanController>().analyze(path);
    if (ok && context.mounted) context.push('/scan-result');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scan = context.watch<ScanController>();
    return AppScreen(
      title: l10n.scanPlantTitle,
      showBack: false,
      child: Center(
        child: scan.loading
            ? Column(mainAxisSize: MainAxisSize.min, children: [
                const CircularProgressIndicator(color: AppColors.greenPrimary),
                const SizedBox(height: 16),
                Text(l10n.analyzingPlantLabel, style: AppTextStyles.inter(15, w: FontWeight.w600)),
              ])
            : Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.photo_camera, size: 84, color: AppColors.greenPrimary),
                ),
                if (scan.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(scan.error!, textAlign: TextAlign.center, style: AppTextStyles.inter(13, c: AppColors.danger)),
                  ),
                const SizedBox(height: 32),
                AppButton(label: l10n.openCameraButton, trailingIcon: Icons.photo_camera, onPressed: () => _scan(context, ImageSource.camera)),
                const SizedBox(height: 12),
                AppButton(label: l10n.chooseFromGalleryButton, variant: AppButtonVariant.orange, trailingIcon: Icons.photo_library_outlined, onPressed: () => _scan(context, ImageSource.gallery)),
              ]),
      ),
    );
  }
}