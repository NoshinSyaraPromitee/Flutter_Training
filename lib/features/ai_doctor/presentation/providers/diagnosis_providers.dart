import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_providers.dart';
import '../../data/diagnosis_api_repository.dart';
import '../../domain/diagnosis_repository.dart';

final diagnosisRepositoryProvider = Provider<DiagnosisRepository>((ref) {
  return DiagnosisApiRepository(ref.watch(apiClientProvider));
});
