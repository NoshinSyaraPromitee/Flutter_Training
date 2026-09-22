import '../domain/achievement.dart';

abstract class AchievementRepository {
  List<Achievement> list();

  /// Total reward points. Currently derived from unlocked achievements;
  /// swap for a real points-ledger read once the backend exists.
  int get points;
}
