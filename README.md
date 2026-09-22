# MyPlantPal

MyPlantPal is a mobile app that helps users identify, understand, and care
for plants. It combines a plant care guide, AI-based plant diagnosis,
fertilizer information, an e-commerce shop, and gamification (points and
rewards). This repository is an industrial-training project built as a
Flutter client backed by a Go REST API.

> Looking for AI-assistant working conventions (architecture rules, coding
> conventions, security rules)? See [`CLAUDE.md`](CLAUDE.md) — this README
> is for humans getting the project running; `CLAUDE.md` is the source of
> truth for how code in this repo should be written.

## Contents

- [What's built so far](#whats-built-so-far)
- [Tech stack](#tech-stack)
- [Architecture](#architecture)
- [Project structure](#project-structure)
- [Getting started](#getting-started)
- [Running the backend](#running-the-backend)
- [Running the Flutter app](#running-the-flutter-app)
- [API documentation](#api-documentation)
- [Localization](#localization)
- [Testing & quality checks](#testing--quality-checks)
- [Known limitations](#known-limitations)
- [Roadmap](#roadmap)

## What's built so far

The current build covers five screens, all wired to a real backend:

| Screen | Route | Description |
|---|---|---|
| Splash | `/` | Launch screen, auto-navigates to Home after 2s |
| Home | `/home` | Dashboard with quick-action tiles and language switcher |
| Maintainance (Plant Care) | `/plants/new` | Register a plant → generates a watering/fertilizer care roadmap |
| Diseases Detection (AI Doctor) | `/ai-doctor` | Submit a plant photo → get a mocked AI diagnosis + cure + disclaimer |
| Fertilizer Making | `/fertilizer` | Search/browse homemade fertilizer recipes, add new ones |

Not yet built: auth, care-guide, shop, wishlist, cart, checkout, orders,
rewards, profile (see [Roadmap](#roadmap) and `CLAUDE.md`'s route list for
the full intended surface).

## Tech stack

| Layer | Technology |
|---|---|
| Frontend | Flutter / Dart |
| State management | Riverpod (`flutter_riverpod`) |
| Navigation | GoRouter |
| Fonts | Google Fonts (Sora for display, Inter for body) |
| Backend | Go (standard library `net/http`, Go 1.22+ pattern routing) |
| Backend architecture | Clean Architecture (domain / usecase / infrastructure / interface) |
| Database | In-memory (MongoDB-shaped, swappable — see [Known limitations](#known-limitations)) |
| AI | Mocked provider today; designed to be swapped for Gemini/Groq |
| API docs | OpenAPI 3.0 spec, served via embedded Swagger UI |
| Containerization | Docker + Docker Compose |
| Localization | English + Bangla (`flutter_localizations` client-side, `Accept-Language`-aware server-side) |

**Hard rule (see `CLAUDE.md`):** Flutter never talks to MongoDB, an AI
provider, Cloudinary, or a payment provider directly — everything goes
through the Go backend over REST.

```
Flutter App --REST API--> Go Backend --> (in-memory today; MongoDB later)
                                     --> AI provider (mocked today; Gemini/Groq later)
```

## Architecture

### Flutter: feature-based "LEGO" architecture

Each feature is a self-contained module with its own `presentation` /
`domain` / `data` split. Shared code lives in `lib/core/`.

```
feature/
├── presentation/   # screens, widgets, Riverpod providers
├── domain/         # entities, repository interfaces
└── data/           # repository implementations (calls core/network)
```

Data flows `Flutter UI → Feature Controller (Riverpod) → Repository →
core/network's ApiClient → REST API → Go Backend`.

### Backend: Clean Architecture

```
domain/          entities + repository/provider interfaces (no framework deps)
usecase/         application logic, depends only on domain interfaces
infrastructure/  in-memory repositories + mock AI providers (implement domain interfaces)
interface/http/  HTTP delivery: middleware, versioned router (v1/), request/response DTOs
```

Repositories and AI providers are swapped by writing a new implementation
of the relevant domain interface and rewiring it in `cmd/api/main.go` —
nothing in `usecase/` or `interface/http/` needs to change.

## Project structure

```
Flutter_Training/
├── CLAUDE.md                  AI-assistant working conventions (architecture, security rules)
├── README.md                  This file
├── l10n.yaml                  Flutter localization codegen config
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart            MaterialApp.router + localization + theme wiring
│   │   └── router/app_router.dart
│   ├── core/
│   │   ├── network/             ApiClient, ApiConfig, ApiException, Riverpod providers
│   │   ├── providers/           localeProvider (current UI language)
│   │   ├── theme/                colors, text styles, spacing, shadows
│   │   └── widgets/              AppButton, AppCard, CurvedHeader, LanguageSwitcher
│   ├── features/
│   │   ├── splash/
│   │   ├── home/
│   │   ├── plants/               "Maintainance" plant care + roadmap
│   │   ├── ai_doctor/            "Diseases Detection"
│   │   └── fertilizer/
│   └── l10n/
│       ├── app_en.arb            English source strings
│       ├── app_bn.arb            Bengali translations
│       └── generated/            flutter gen-l10n output (gitignored, regenerated on build)
└── backend/
    ├── cmd/api/main.go           entry point, dependency wiring
    ├── internal/
    │   ├── domain/                plant, fertilizer, diagnosis, chat, apperr
    │   ├── usecase/                one package per feature
    │   ├── infrastructure/
    │   │   ├── repository/memory/  in-memory repos + seed data
    │   │   └── ai/                 mock AI providers
    │   ├── interface/http/
    │   │   ├── v1/                 versioned handlers + router
    │   │   ├── respond/            shared JSON response helpers
    │   │   ├── reqlocale/          Accept-Language resolution
    │   │   ├── openapi.yaml        API spec
    │   │   └── docs.go             embeds + serves the spec + Swagger UI
    │   ├── idgen/, config/
    ├── Dockerfile
    └── docker-compose.yml
```

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart ^3.13.0 — check with `flutter --version`)
- [Go](https://go.dev/dl/) 1.22+
- Docker + Docker Compose (optional, for containerized backend)
- A device/emulator or a browser (Chrome) to run the Flutter app

### Clone and install

```bash
git clone <repo-url>
cd Flutter_Training
flutter pub get
cd backend && go mod download && cd ..
```

## Running the backend

**Option A — directly with Go:**

```bash
cd backend
go run ./cmd/api
# listening on :8080 by default; override with PORT=xxxx
```

**Option B — Docker Compose:**

```bash
cd backend
docker compose up --build
```

Either way, verify it's up:

```bash
curl http://localhost:8080/health
# {"data":{"status":"ok"}}
```

Repositories are in-memory — all data resets when the process restarts.
Fertilizer data comes pre-seeded (English + Bengali).

## Running the Flutter app

```bash
flutter run                 # pick a connected device/emulator
flutter run -d chrome       # run in the browser
```

The Flutter client points at `http://localhost:8080` by default
(`lib/core/network/api_config.dart`). **Android emulators** can't reach
the host machine via `localhost` — the app automatically uses
`10.0.2.2:8080` instead when running on Android, so no config change is
needed. iOS simulators and web both use `localhost` directly.

If you're running on a **physical device**, update
`ApiConfig.baseUrl` to your machine's LAN IP.

## API documentation

With the backend running, open:

- **Swagger UI:** [http://localhost:8080/docs](http://localhost:8080/docs)
- **Raw OpenAPI spec:** [http://localhost:8080/openapi.yaml](http://localhost:8080/openapi.yaml)

Endpoints are versioned under `/api/v1/...` (plants, fertilizers,
diagnoses, chat), with `/health` and `/api/v1/health` for liveness checks.

## Localization

The app ships English and Bengali translations for all UI chrome (labels,
buttons, headers, dialogs). Switch languages at runtime via the globe icon
in any screen header.

- Client strings live in `lib/l10n/app_en.arb` / `app_bn.arb`, compiled by
  `flutter gen-l10n` (runs automatically via `generate: true` in
  `pubspec.yaml` whenever you build or `flutter pub get`).
- The client sends the active language as an `Accept-Language` header on
  every API request. The backend uses it to return localized text for
  seeded/generated content — fertilizer recipes, AI diagnosis results, and
  plant-care tips.
- User-submitted content (e.g. a fertilizer a user adds themselves) is
  never auto-translated — it's returned as-is regardless of the requested
  language.
- Adding a string: add the key to both `.arb` files, then re-run `flutter
  pub get` (or just re-run the app) to regenerate
  `lib/l10n/generated/app_localizations.dart`.

## Testing & quality checks

```bash
# Flutter
flutter analyze
flutter test

# Backend
cd backend
gofmt -l .        # should print nothing
go vet ./...
go build ./...
go test ./...             # add -v for per-test output, -race to check the
                           # mutex-guarded in-memory repositories, -cover
                           # for a coverage summary
```

The backend has real test coverage: domain logic (e.g. English/Bengali
`Localized()` fallback behavior), usecases (validation, roadmap
generation, localization), the in-memory repositories, and full-stack
HTTP tests that exercise the real router → middleware → handler →
usecase → repository chain via `httptest` (including
`Accept-Language`-driven localization and CORS headers). No Flutter
widget/integration tests exist yet.

## Known limitations

This is a training project at an early phase. Notable gaps, by design for
now:

- **No authentication.** There's no login/register flow or route guards
  yet, even though `CLAUDE.md` documents the intended routes.
- **In-memory backend storage.** Every repository is a mutex-guarded map;
  nothing persists across a backend restart. Swapping in MongoDB means
  writing a new repository implementation per domain interface — the
  usecase and HTTP layers don't change.
- **Mocked AI.** `/api/v1/diagnoses` cycles through a small set of canned
  results; it isn't calling Gemini/Groq. The `diagnosis.Provider`
  interface is already in place for that swap.
- **No real photo capture.** The AI Doctor screen's "Upload"/"Camera"
  buttons submit a placeholder 1×1 image — there's no image picker wired
  up yet, so every diagnosis call exercises the endpoint but not real
  image content.
- **Fertilizer search doesn't search Bengali text** — only the English
  name/category fields are indexed.
- **Shop, cart, checkout, wishlist, reviews, gamification, profile** are
  not implemented; they exist only as entries in `CLAUDE.md`'s roadmap.

## Roadmap

See `CLAUDE.md` → **Development Phases** for the full phased roadmap
(foundation → auth → plant care → AI Doctor → fertilizer → shop →
checkout → gamification → testing). This repo is currently partway
through phases 3–5, built out of order to prioritize a working vertical
slice (UI → API → backend) over strict phase sequencing.
