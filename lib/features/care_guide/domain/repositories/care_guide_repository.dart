import 'package:plantpal/features/care_guide/domain/entities/care_guide.dart';
import 'package:plantpal/features/plants/domain/entities/plant.dart';

abstract class CareGuideRepository {
  /// General guide when [plant] is null, otherwise personalised to that plant.
  CareGuide guideFor(Plant? plant);
}