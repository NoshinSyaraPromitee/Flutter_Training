import 'package:plantpal/features/fertilizer/domain/model/fertilizer.dart';

abstract class FertilizerRepository {
  Future<FertilizerCatalog> getCatalog();
}