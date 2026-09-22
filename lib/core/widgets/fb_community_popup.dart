import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';

class FbCommunityPopup {
  FbCommunityPopup._();

  static const _storage = FlutterSecureStorage();
  static const _seenKey = 'fb_community_popup_seen';
  static const communityUrl = 'https://facebook.com/groups/plantpal';
  static bool _scheduledThisSession = false;

  static Future<void> maybeShow(BuildContext context) async {
    if (_scheduledThisSession) return;
    _scheduledThisSession = true;
    final seen = await _storage.read(key: _seenKey);
    if (seen == 'true' || !context.mounted) return;
    await showDialog<void>(context: context, builder: (_) => const _FbCommunityDialog());
  }

  static Future<void> _markSeen() => _storage.write(key: _seenKey, value: 'true');
}

class _FbCommunityDialog extends StatelessWidget {
  const _FbCommunityDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircleAvatar(radius: 28, backgroundColor: Color(0xFF1877F2), child: Icon(Icons.groups, color: Colors.white, size: 30)),
          const SizedBox(height: 16),
          Text('Join the PlantPal Community', style: AppTextStyles.inter(17, w: FontWeight.w700), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(
            'Swap plant-care tips and get help from other growers in our Facebook group.',
            style: AppTextStyles.inter(13, c: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1877F2), padding: const EdgeInsets.symmetric(vertical: 12)),
              onPressed: () async {
                await FbCommunityPopup._markSeen();
                if (context.mounted) Navigator.of(context).pop();
                await launchUrl(Uri.parse(FbCommunityPopup.communityUrl), mode: LaunchMode.externalApplication);
              },
              child: const Text('Join Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
          TextButton(
            onPressed: () async {
              await FbCommunityPopup._markSeen();
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Text('Maybe Later', style: AppTextStyles.inter(13, c: AppColors.textMuted)),
          ),
        ]),
      ),
    );
  }
}
