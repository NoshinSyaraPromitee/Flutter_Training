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

/// The user's earned-points balance — starts at whatever the unlocked
/// achievements are worth, then grows as care tasks are completed (see
/// [MyPlants.markWatered]). No points backend exists yet (see CLAUDE.md:
/// point-balance changes must be validated server-side eventually), so
/// this is an in-memory, session-local balance for now.
@Riverpod(keepAlive: true)
class Points extends _$Points {
  @override
  int build() => ref.watch(achievementRepositoryProvider).points;

  void add(int amount) => state += amount;
}
