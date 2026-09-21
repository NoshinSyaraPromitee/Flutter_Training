/// Why a diagnosis attempt failed, at a level the UI can act on.
enum DiagnosisFailureKind {
  /// The backend couldn't be reached at all — not running, wrong host, or
  /// no network. The most likely one during local development.
  network,

  /// The backend rejected the request (HTTP 400), e.g. an empty or
  /// undecodable image.
  invalidRequest,

  /// The backend was reached but something went wrong on its side, or it
  /// returned a shape this client doesn't understand.
  server,

  /// Anything else.
  unknown,
}

/// A failure the AI Doctor UI can present to the user.
///
/// Repositories translate transport-level errors (Dio, JSON) into this, so
/// nothing above the data layer needs to import Dio or know about HTTP
/// status codes.
class DiagnosisFailure implements Exception {
  const DiagnosisFailure(
    this.message, {
    this.kind = DiagnosisFailureKind.unknown,
  });

  /// Safe to show directly in the UI.
  final String message;

  final DiagnosisFailureKind kind;

  @override
  String toString() => message;
}
