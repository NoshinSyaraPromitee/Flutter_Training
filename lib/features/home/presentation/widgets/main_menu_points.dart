import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';

/// Gold coin + dark pill: "999 points ( 10 taka)".
class PointsPill extends StatelessWidget {
  const PointsPill({super.key, required this.points, required this.taka});
  final int points;
  final int taka;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 13),
          padding: const EdgeInsets.fromLTRB(20, 3, 10, 3),
          decoration: BoxDecoration(
            color: const Color(0xFF7A4B12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '$points points ( $taka taka)',
            style: AppTextStyles.inter(11, w: FontWeight.w800, c: const Color(0xFFFCE8B8)),
          ),
        ),
        const Positioned(left: 0, top: -4, child: _Coin()),
      ],
    );
  }
}

class _Coin extends StatelessWidget {
  const _Coin();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFE04A), Color(0xFFF5A300)],
        ),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))],
      ),
      child: Center(
        child: Container(
          width: 17,
          height: 17,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFF2A8), width: 1.5),
          ),
          child: const Icon(Icons.star_rounded, size: 11, color: Color(0xFFFFF2A8)),
        ),
      ),
    );
  }
}
