import 'package:plantpal/features/gamification/domain/model/achievement.dart';

abstract class AchievementRepository {
  List<Achievement> getAchievements();
}