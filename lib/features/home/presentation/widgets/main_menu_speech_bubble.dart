import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';

/// Gold-bordered speech bubble with a tail at the bottom-left.
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
          padding: const EdgeInsets.fromLTRB(11, 10, 11, 10 + _BubblePainter.tail),
          child: Text(text, style: AppTextStyles.inter(10, w: FontWeight.w800, h: 1.3)),
        ),
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  const _BubblePainter();
  static const double tail = 10;
  static const double border = 5;

  @override
  void paint(Canvas canvas, Size size) {
    final gold = Paint()..color = const Color(0xFF8FA23E);
    final cream = Paint()..color = const Color(0xFFFFF6DC);
    final body = Rect.fromLTWH(0, 0, size.width, size.height - tail);
    canvas.drawRRect(RRect.fromRectAndRadius(body, const Radius.circular(12)), gold);
    canvas.drawRRect(RRect.fromRectAndRadius(body.deflate(border), const Radius.circular(3)), cream);
    final path = Path()
      ..moveTo(0, body.bottom - 6)
      ..lineTo(0, size.height)
      ..lineTo(18, body.bottom - 6)
      ..close();
    canvas.drawPath(path, gold);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
