import 'package:flutter/material.dart';

/// A single gamification badge. There's no rewards backend yet (see
/// CLAUDE.md's Gamification phase), so achievements are a static local
/// list for now — see [LocalAchievementRepository].
class Achievement {
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.unlocked,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final bool unlocked;
}
