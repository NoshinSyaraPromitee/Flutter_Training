/// A plant diagnosis result: an issue and a suggested cure.
///
/// This screen is UI-only for now, so the result is a static placeholder
/// matching the Figma design rather than a real AI call.
class DiagnosisResult {
  const DiagnosisResult({required this.issue, required this.cure});

  final String issue;
  final String cure;
}

const mockDiagnosisResult = DiagnosisResult(
  issue: 'Your plant is suffering from Phosphorus deficiency.',
  cure: 'Use Triple Superphosphate (TSP), and Single Superphosphate (SSP)',
);

/// AI Doctor results are assistance, never a guaranteed diagnosis.
const diagnosisDisclaimer =
    'This result is AI-assisted and may be inaccurate. It is not a '
    'substitute for professional horticultural or botanical advice.';
