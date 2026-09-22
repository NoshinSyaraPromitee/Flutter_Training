import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';

/// Camera / Chat with expert / Back.
class MainMenuBottomBar extends StatelessWidget {
  const MainMenuBottomBar({
    super.key,
    required this.onCamera,
    required this.onChat,
    required this.onBack,
  });
  final VoidCallback onCamera;
  final VoidCallback onChat;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFD3D9CC),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BarItem(
                label: 'Camera',
                icon: const Icon(Icons.photo_camera_outlined, size: 22, color: Color(0xFF222222)),
                onTap: onCamera,
              ),
              _BarItem(
                label: 'Chat with expert',
                pill: const Color(0xFFB4BCAE),
                icon: Opacity(
                  opacity: 0.45,
                  child: Image.asset('assets/images/chat_bot_icon.png', width: 22, height: 22),
                ),
                onTap: onChat,
              ),
              _BarItem(
                label: 'Back',
                icon: const Icon(Icons.arrow_back, size: 22, color: Color(0xFF222222)),
                onTap: onBack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  const _BarItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.pill = const Color(0xFFC3CBBB),
  });
  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final Color pill;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: pill, borderRadius: BorderRadius.circular(16)),
              child: icon,
            ),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.inter(11, w: FontWeight.w600, c: const Color(0xFF4A4F44))),
          ],
        ),
      ),
    );
  }
}