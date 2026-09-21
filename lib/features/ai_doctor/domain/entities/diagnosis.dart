/// The result of analyzing a single plant photo.
///
/// This mirrors the Go backend's `internal/domain/diagnosis.Diagnosis`
/// one-for-one. Keeping the two in lockstep is deliberate: the backend owns
/// the contract, and any field here that the backend can't actually produce
/// would have to be invented on the client, which is worse than not showing
/// it at all.
///
/// When the real Gemini/Groq provider replaces the mock, `symptoms` and a
/// severity value should be added to the Go entity *and* here in the same
/// change — not here alone.
///
/// A plain domain entity: no knowledge of Dio, JSON, or where the data came
/// from. Parsing lives in `data/models/diagnosis_dto.dart`.
class Diagnosis {
  const Diagnosis({
    required this.id,
    required this.issue,
    required this.cure,
    required this.disclaimer,
    required this.createdAt,
    this.plantId,
  });

  /// Backend-assigned ID, e.g. `diag_a1b2c3`. Needed to reference this
  /// entry later from the diagnosis log.
  final String id;

  /// The plant in "My Plants" this diagnosis was filed against, if the user
  /// started from a specific plant. Null for a one-off photo.
  final String? plantId;

  /// What the AI believes is wrong, e.g. "Your plant is suffering from
  /// Phosphorus deficiency."
  final String issue;

  /// Suggested treatment for [issue].
  final String cure;

  /// Backend-supplied disclaimer. Always rendered — per the planning doc,
  /// AI Doctor results are assistance, never a guaranteed diagnosis. It
  /// comes from the server rather than being hardcoded in the UI so the
  /// wording stays consistent across every client.
  final String disclaimer;

  /// When the backend produced this diagnosis (converted to local time).
  final DateTime createdAt;
}
