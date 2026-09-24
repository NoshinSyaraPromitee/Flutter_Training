import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../gamification/presentation/providers/points_provider.dart';

class PointsBadge extends StatelessWidget {
  const PointsBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final points = context.watch<PointsController>().balance;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.stars_rounded, size: 20),
          const SizedBox(width: 6),
          Text(
            '$points pts',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}