import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_providers.dart';
import '../../repository/plant_api_repository.dart';
import '../../repository/plant_repository.dart';

part 'plant_providers.g.dart';

@Riverpod(keepAlive: true)
PlantRepository plantRepository(Ref ref) =>
    PlantApiRepository(ref.watch(apiClientProvider));
