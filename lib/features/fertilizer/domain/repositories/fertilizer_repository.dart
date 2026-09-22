import 'package:plantpal/features/fertilizer/domain/entities/fertilizer.dart';

abstract class FertilizerRepository {
  Future<FertilizerCatalog> getCatalog();
}