import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// Riverpod 3.0 moved StateProvider out of the main API and into this
// dedicated import — see https://riverpod.dev/docs/3.0_migration.
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/entities/diagnosis.dart';
import '../../domain/repositories/diagnosis_repository.dart';

/// Bridges the GetIt-registered [DiagnosisRepository] into the Riverpod
/// provider tree, so [DiagnosisNotifier] doesn't have to reach into GetIt
/// directly and stays easy to test/override.
final diagnosisRepositoryProvider = Provider<DiagnosisRepository>((ref) {
  return getIt<DiagnosisRepository>();
});

/// The photo the user has picked for this diagnosis session, as raw bytes.
/// Null until they take or choose one.
///
/// Bytes rather than an `XFile` so the same value drives both the on-screen
/// preview and the upload, and so nothing outside the picker call itself
/// needs `image_picker`. Bytes also work on web, where `dart:io`'s `File`
/// doesn't exist.
final selectedPlantImageProvider = StateProvider<Uint8List?>((ref) => null);

/// Diagnosis result for the currently selected photo.
///
/// - Nothing analyzed yet -> `AsyncData(null)`
/// - Analysis in progress -> `AsyncLoading`
/// - Analysis failed      -> `AsyncError` (a `DiagnosisFailure`)
/// - Analysis complete    -> `AsyncData(Diagnosis)`
class DiagnosisNotifier extends AsyncNotifier<Diagnosis?> {
  @override
  FutureOr<Diagnosis?> build() => null;

  /// Sends [imageBytes] to the repository and updates state with the result.
  ///
  /// [plantId] is accepted so the diagnosis can be filed against a plant
  /// from "My Plants" later; nothing passes it yet.
  Future<void> diagnose(Uint8List imageBytes, {String? plantId}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(diagnosisRepositoryProvider)
          .diagnosePlant(imageBytes: imageBytes, plantId: plantId),
    );
  }

  /// Clears any previous result — used when the user picks a new photo.
  void reset() {
    state = const AsyncValue.data(null);
  }
}

final diagnosisProvider =
    AsyncNotifierProvider<DiagnosisNotifier, Diagnosis?>(
      DiagnosisNotifier.new,
    );
