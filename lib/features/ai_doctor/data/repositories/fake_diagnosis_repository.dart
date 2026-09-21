import 'dart:math';

import '../../domain/entities/diagnosis.dart';
import '../../domain/repositories/diagnosis_repository.dart';

/// Returns one of a few canned [Diagnosis] results after a short simulated
/// delay, so the AI Doctor screen remains demoable while the real backend
/// endpoint is being wired up.
///
/// This is intentionally kept in sync with the actual domain model used by
/// the app: the UI does not know or care whether the data came from a mock or
/// from the Go API.
class FakeDiagnosisRepository implements DiagnosisRepository {
  FakeDiagnosisRepository({Random? random}) : _random = random ?? Random();

  final Random _random;

  static final List<Diagnosis> _sampleResults = [
    Diagnosis(
      id: 'diag_healthy_01',
      issue: 'No disease detected',
      cure: 'Keep up the current watering and light routine. Wipe the leaves '
          'occasionally to keep them free of dust.',
      disclaimer:
          'This diagnosis is AI-assisted guidance and should be used with a '
          'careful visual check of the plant, not as a guaranteed diagnosis.',
      createdAt: DateTime.now(),
    ),
    Diagnosis(
      id: 'diag_leaf_spot_01',
      issue: 'Early-stage leaf spot (fungal)',
      cure: 'Remove the affected leaves, avoid watering the foliage directly, '
          'and improve airflow around the plant. A copper-based fungicide '
          'can help if it spreads.',
      disclaimer:
          'This diagnosis is AI-assisted guidance and should be used with a '
          'careful visual check of the plant, not as a guaranteed diagnosis.',
      createdAt: DateTime.now(),
    ),
    Diagnosis(
      id: 'diag_root_rot_01',
      issue: 'Root rot (overwatering)',
      cure: 'Remove the plant from its pot, trim away any soft or black roots, '
          'let the root ball dry out, and repot in fresh, well-draining soil. '
          'Cut back watering significantly going forward.',
      disclaimer:
          'This diagnosis is AI-assisted guidance and should be used with a '
          'careful visual check of the plant, not as a guaranteed diagnosis.',
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Future<Diagnosis> diagnosePlant({
    required Uint8List imageBytes,
    String? plantId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1800));

    final sample = _sampleResults[_random.nextInt(_sampleResults.length)];

    return Diagnosis(
      id: sample.id,
      plantId: plantId ?? sample.plantId,
      issue: sample.issue,
      cure: sample.cure,
      disclaimer: sample.disclaimer,
      createdAt: DateTime.now(),
    );
  }
}
