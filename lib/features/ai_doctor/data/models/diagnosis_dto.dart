import '../../domain/entities/diagnosis.dart';
import '../../domain/failures/diagnosis_failure.dart';

/// Maps the backend's diagnosis JSON to a [Diagnosis].
///
/// The backend wraps every success in `{"data": ...}` (see
/// `internal/interface/http/respond/respond.go`); this type handles the
/// inner object only — unwrapping `data` is the repository's job.
///
/// Expected shape, from `internal/domain/diagnosis/diagnosis.go`:
/// ```json
/// {
///   "id": "diag_...",
///   "plantId": "plant_...",   // omitted when null
///   "issue": "...",
///   "cure": "...",
///   "disclaimer": "...",
///   "createdAt": "2026-09-20T06:15:00Z"
/// }
/// ```
class DiagnosisDto {
  const DiagnosisDto({
    required this.id,
    required this.issue,
    required this.cure,
    required this.disclaimer,
    required this.createdAt,
    this.plantId,
  });

  final String id;
  final String? plantId;
  final String issue;
  final String cure;
  final String disclaimer;
  final String createdAt;

  /// Throws [DiagnosisFailure] rather than a raw cast error if the payload
  /// isn't what we expect — most likely cause is the Go entity changing
  /// without this file being updated.
  factory DiagnosisDto.fromJson(Map<String, dynamic> json) {
    try {
      return DiagnosisDto(
        id: json['id'] as String,
        plantId: json['plantId'] as String?,
        issue: json['issue'] as String,
        cure: json['cure'] as String,
        disclaimer: json['disclaimer'] as String? ?? '',
        createdAt: json['createdAt'] as String,
      );
    } on TypeError {
      throw const DiagnosisFailure(
        'The server sent a diagnosis in an unexpected format.',
        kind: DiagnosisFailureKind.server,
      );
    }
  }

  Diagnosis toEntity() {
    // Go marshals time.Time as RFC 3339, which DateTime.parse handles. Fall
    // back to "now" rather than failing the whole diagnosis over a
    // timestamp the user barely looks at.
    final parsed = DateTime.tryParse(createdAt)?.toLocal() ?? DateTime.now();

    return Diagnosis(
      id: id,
      plantId: plantId,
      issue: issue,
      cure: cure,
      disclaimer: disclaimer,
      createdAt: parsed,
    );
  }
}
