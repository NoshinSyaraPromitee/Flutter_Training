import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_providers.dart';
import '../../repository/diagnosis_api_repository.dart';
import '../../repository/diagnosis_repository.dart';

part 'diagnosis_providers.g.dart';

@Riverpod(keepAlive: true)
DiagnosisRepository diagnosisRepository(Ref ref) {
  return DiagnosisApiRepository(ref.watch(apiClientProvider));
}
