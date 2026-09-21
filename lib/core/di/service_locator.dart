import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/ai_doctor/data/repositories/api_diagnosis_repository.dart';
import '../../features/ai_doctor/domain/repositories/diagnosis_repository.dart';
import '../network/dio_client.dart';

final GetIt getIt = GetIt.instance;

/// Registers every feature's dependencies. Call once, before `runApp()`.
void setupLocator() {
  // Core
  getIt.registerLazySingleton<Dio>(() => DioClient.instance);

  // AI Doctor
  // Now backed by the real Go endpoint (POST /api/v1/diagnoses) instead of
  // the fake repository. The AI behind it is still the backend's mock
  // provider, but that swap happens server-side and doesn't reach here.
  getIt.registerLazySingleton<DiagnosisRepository>(
    () => ApiDiagnosisRepository(getIt<Dio>()),
  );
}
