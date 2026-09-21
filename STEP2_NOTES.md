# AI Doctor — Step 2: wired to the real Go backend

Extract over your local clone. All paths are correct relative to the Flutter
project root.

## Delete this file after extracting

    lib/features/ai_doctor/data/repositories/fake_diagnosis_repository.dart

It references the old entity fields (`plantName`, `status`, `symptoms`,
`confidence`) and will not compile. Nothing imports it any more.

## What changed

| File | Change |
| --- | --- |
| `domain/entities/diagnosis.dart` | Rewritten to mirror the Go entity: `id, plantId, issue, cure, disclaimer, createdAt`. Invented fields removed. |
| `domain/failures/diagnosis_failure.dart` | **New.** Showable failure type, so the UI never imports Dio. |
| `domain/repositories/diagnosis_repository.dart` | Signature now takes `Uint8List` + optional `plantId` instead of an `XFile`. Domain no longer depends on `image_picker`. |
| `data/models/diagnosis_dto.dart` | **New.** JSON mapping for the backend payload. |
| `data/repositories/api_diagnosis_repository.dart` | **New.** `POST /api/v1/diagnoses` via Dio, unwraps `{"data": ...}`, maps `DioException` → `DiagnosisFailure`. |
| `core/network/dio_client.dart` | Base URL now points at the local Go backend, platform-aware (`10.0.2.2` on the Android emulator). |
| `core/di/service_locator.dart` | Registers `ApiDiagnosisRepository` instead of the fake. |
| `presentation/providers/diagnosis_provider.dart` | `selectedPlantImageProvider` holds bytes; `diagnose(bytes, {plantId})`. |
| `presentation/widgets/diagnosis_result_card.dart` | Rewritten for issue / cure / server disclaimer. No severity badge, no confidence %. |
| `presentation/screens/ai_doctor_screen.dart` | Reads bytes from the provider (local `setState` preview gone); error panel shows the backend's own message. |
| `android/.../AndroidManifest.xml` | Added `INTERNET` permission and `usesCleartextTraffic="true"` (local dev only — see the comment in the file). |

No `pubspec.yaml` change: `dio` and `image_picker` were already added in
step 1. No `app_router.dart` or `main.dart` change.

## Running it

Two processes. Backend first:

    cd backend
    go run ./cmd/api
    # -> myplantpal backend listening on :8080

Check it's up: <http://localhost:8080/health> should return
`{"data":{"status":"ok"}}`. The full API spec is served at
<http://localhost:8080/docs>.

Then the app:

    flutter run -d chrome

Home screen → upload button or Disease Detection card → pick a photo →
Analyze. You should get one of the backend mock's three
nutrient-deficiency results, rotating in order on each call.

To see the error path, stop the Go process and tap Analyze again.

## Still TODO (not in this step)

- Real Gemini/Groq provider, replacing
  `internal/infrastructure/ai/mock_diagnosis_provider.go`. Backend-only
  change; no Flutter file moves.
- Add `symptoms` (planning doc §7.1) and a severity value to the Go entity
  **and** `openapi.yaml` **and** this Dart entity, in one commit, once the
  real provider can actually produce them.
- Diagnosis log screen, reading `GET /api/v1/diagnoses`. Note the backend
  already persists every analysis automatically, so there is nothing for an
  "Add to Log" button to do.
- Cloudinary upload instead of base64-in-JSON.
