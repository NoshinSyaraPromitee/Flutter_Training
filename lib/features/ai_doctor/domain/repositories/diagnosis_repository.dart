import 'dart:typed_data';

import '../entities/diagnosis.dart';

/// Submits a plant photo for analysis by the Go backend.
///
/// The presentation layer only ever talks to this interface.
///
/// Note the signature takes raw bytes rather than an `XFile`: the domain
/// layer shouldn't depend on `image_picker`, and how the photo was obtained
/// (camera, gallery, or a test fixture) is none of its business. The screen
/// already reads bytes to render the preview, so nothing is lost.
abstract class DiagnosisRepository {
  /// Sends [imageBytes] off for analysis, optionally filed against
  /// [plantId] from "My Plants".
  ///
  /// Throws a [DiagnosisFailure] on any failure, so callers can surface an
  /// error state via `AsyncValue.guard`.
  Future<Diagnosis> diagnosePlant({
    required Uint8List imageBytes,
    String? plantId,
  });
}
