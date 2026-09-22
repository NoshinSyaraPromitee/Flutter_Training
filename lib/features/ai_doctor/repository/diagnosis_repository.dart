import 'dart:typed_data';

import '../domain/diagnosis.dart';

abstract class DiagnosisRepository {
  /// Submits a plant photo for analysis. [imageBytes] is sent to the
  /// backend as base64; there is no real image picker yet, so callers pass
  /// a placeholder image.
  Future<Diagnosis> analyze(Uint8List imageBytes);
}
