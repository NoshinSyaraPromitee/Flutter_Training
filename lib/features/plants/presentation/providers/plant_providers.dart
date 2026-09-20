import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_providers.dart';
import '../../data/plant_api_repository.dart';
import '../../domain/plant_repository.dart';

final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  return PlantApiRepository(ref.watch(apiClientProvider));
});
