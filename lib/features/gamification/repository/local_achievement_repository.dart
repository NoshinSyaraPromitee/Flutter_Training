import 'package:flutter/material.dart';

import '../domain/achievement.dart';
import 'achievement_repository.dart';

const _pointsPerAchievement = 50;

/// Static badges for now — no rewards backend exists yet.
class LocalAchievementRepository implements AchievementRepository {
  static const _achievements = [
    Achievement(
      id: 'first_plant',
      title: 'First Sprout',
      description: 'Add your first plant',
      icon: Icons.grain,
      unlocked: true,
    ),
    Achievement(
      id: 'hydration_hero',
      title: 'Hydration Hero',
      description: 'Water a plant on schedule',
      icon: Icons.water_drop,
      unlocked: true,
    ),
    Achievement(
      id: 'green_thumb',
      title: 'Green Thumb',
      description: 'Keep a plant healthy for 7 days',
      icon: Icons.eco,
      unlocked: true,
    ),
    Achievement(
      id: 'scan_master',
      title: 'Scan Master',
      description: 'Use AI Doctor for the first time',
      icon: Icons.photo_camera,
      unlocked: false,
    ),
    Achievement(
      id: 'plant_legend',
      title: 'Plant Legend',
      description: 'Grow a collection of 10 plants',
      icon: Icons.emoji_events,
      unlocked: false,
    ),
  ];

  @override
  List<Achievement> list() => _achievements;

  @override
  int get points =>
      _achievements.where((a) => a.unlocked).length * _pointsPerAchievement;
}
