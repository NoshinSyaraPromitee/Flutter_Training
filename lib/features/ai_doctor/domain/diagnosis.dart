/// A plant diagnosis result returned by /api/v1/diagnoses. Per project
/// convention, this is always assistance, never a guaranteed diagnosis —
/// [disclaimer] must be shown alongside [issue]/[cure] in the UI.
class Diagnosis {
  const Diagnosis({
    required this.id,
    required this.issue,
    required this.cure,
    required this.disclaimer,
  });

  final String id;
  final String issue;
  final String cure;
  final String disclaimer;

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      id: json['id'] as String,
      issue: json['issue'] as String,
      cure: json['cure'] as String,
      disclaimer: json['disclaimer'] as String,
    );
  }
}
