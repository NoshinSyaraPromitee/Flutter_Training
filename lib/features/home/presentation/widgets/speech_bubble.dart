import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// A small tailed speech bubble, used for the mascot's greeting on Home.
class SpeechBubble extends StatelessWidget {
  const SpeechBubble({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: const _BubblePainter(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            14,
            12,
            14,
            12 + _BubblePainter.tail,
          ),
          child: Text(
            text,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF6B4A00),
            ),
          ),
        ),
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  const _BubblePainter();
  static const double tail = 10;
  static const double border = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final gold = Paint()..color = const Color(0xFFDDB54A);
    final cream = Paint()..color = const Color(0xFFFFF6DC);
    final body = Rect.fromLTWH(0, 0, size.width, size.height - tail);
    canvas.drawRRect(
      RRect.fromRectAndRadius(body, const Radius.circular(14)),
      gold,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(body.deflate(border), const Radius.circular(10)),
      cream,
    );
    final path = Path()
      ..moveTo(18, body.bottom - 4)
      ..lineTo(10, size.height)
      ..lineTo(34, body.bottom - 4)
      ..close();
    canvas.drawPath(path, gold);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
