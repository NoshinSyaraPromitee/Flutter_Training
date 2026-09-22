import 'package:plantpal/features/gamification/domain/entities/achievement.dart';

abstract class AchievementRepository {
  List<Achievement> getAchievements();
}