import '../entities/achievement.dart';

abstract class AchievementRepository {
  List<Achievement> getAchievements();
}