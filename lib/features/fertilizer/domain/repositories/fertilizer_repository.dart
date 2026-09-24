import '../entities/fertilizer.dart';

abstract class FertilizerRepository {
  Future<FertilizerCatalog> getCatalog();
}