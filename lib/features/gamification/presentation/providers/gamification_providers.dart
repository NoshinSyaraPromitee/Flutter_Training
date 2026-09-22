import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/achievement.dart';
import '../../repository/achievement_repository.dart';
import '../../repository/local_achievement_repository.dart';

part 'gamification_providers.g.dart';

@Riverpod(keepAlive: true)
AchievementRepository achievementRepository(Ref ref) =>
    LocalAchievementRepository();

@Riverpod(keepAlive: true)
List<Achievement> achievements(Ref ref) =>
    ref.watch(achievementRepositoryProvider).list();

@Riverpod(keepAlive: true)
int points(Ref ref) => ref.watch(achievementRepositoryProvider).points;
