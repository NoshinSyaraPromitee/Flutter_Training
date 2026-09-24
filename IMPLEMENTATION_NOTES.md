# Frontend requirements — what was implemented

This pass covers the **frontend-only** items from your list. Items already
present in the project before this pass (GoRouter, Provider, dark/light mode,
main.dart cleanliness, LEGO+clean architecture, basic caching) were verified
and, where needed, extended — not rebuilt from scratch.

## 1. GoRouter ✅ (already present, reorganized)
Already used for all navigation. `app/router/app_router.dart` was split into
`app/router/plant_routes.dart` and `app/router/shop_routes.dart` to respect
the 120-line rule; behavior is unchanged.

## 2. Localization — Bangla + English ✅ (new)
- `lib/l10n/app_en.arb`, `lib/l10n/app_bn.arb` — source strings.
- `lib/l10n/app_localizations.dart` (+ `_en.dart` / `_bn.dart`) — a
  hand-written class shaped exactly like Flutter's official `flutter
  gen-l10n` output (`AppLocalizations.of(context).someKey`), so it's a
  drop-in replacement if you later enable real codegen (`l10n.yaml` is
  included, ready for that).
- Wired into `MaterialApp.router` in `app/app.dart` (`localizationsDelegates`,
  `supportedLocales`, `locale`).
- Language switch lives in **Settings → General → Language** and is driven by
  Riverpod (see below). Applied to: bottom nav bar, Main Menu, Settings,
  Landing screen. The same `AppLocalizations.of(context)` pattern can be
  applied to the remaining screens the same way — search for hardcoded
  strings like `Text('...')` and swap in `t.someKey` after adding the key to
  all three `AppLocalizations*` files + both `.arb` files.

## 3. Dark / Light mode ✅ (already present)
`SettingsController` (Provider) + `AppTheme` already handled this correctly.
Untouched.

## 4. Codegen for model files ✅ (new, 2 examples wired end-to-end)
- `features/plants/data/models/plant_dto.dart` (+ generated
  `plant_dto.g.dart`) replaces the old hand-written `plant_model.dart`
  mapper. `PlantRepositoryImpl` now uses `PlantDto.fromJson(...).toEntity()`
  / `PlantDto.fromEntity(...).toJson()`.
- `features/auth/domain/entities/auth_user.dart` (+ generated
  `auth_user.g.dart`) — same pattern, smaller example.
- **Important:** the `.g.dart` files were hand-authored to match what
  `json_serializable` would generate, because this environment can't run
  `flutter pub get` / `dart run build_runner build`. Before shipping, run:
  ```
  flutter pub get
  dart run build_runner build --delete-conflicting-outputs
  ```
  to have the real tool regenerate them (it should produce equivalent code —
  if it doesn't, the tool's output wins).
- Other model-shaped classes (`AchievementDto`, `ProductDto`, etc.) can follow
  the same `@JsonSerializable()` + `part 'x.g.dart'` pattern.

## 5. Lego + Clean architecture ✅ (already present)
Already structured as `feature/{presentation,domain,data}` with shared code
in `core/`, per your `CLAUDE.md`. Untouched.

## 6. 120-line-per-file limit ✅ (enforced)
7 files were over the limit; all were split by extracting widgets/route
groups into sibling files:
- `main_menu_widgets.dart` → `main_menu_points.dart`, `main_menu_speech_bubble.dart`, `main_menu_widgets.dart`, `main_menu_bottom_bar.dart`
- `main_menu_screen.dart` → + `main_menu_mascot.dart`, `main_menu_upload_button.dart`
- `care_guide_screen.dart` → + `care_guide_sections.dart`, `care_guide_tips_problems.dart`
- `app_router.dart` → + `plant_routes.dart`, `shop_routes.dart`
- `splash_screen.dart` → + `splash_decor.dart`
- `plant_details_screen.dart` → + `plant_details_header.dart`, `plant_stat_tiles.dart`
- `fertilizer_screen.dart` → + `fertilizer_list_widgets.dart`

Every `.dart` file in `lib/` is now ≤120 lines.

## 7. main.dart stays clean ✅
Still just bootstraps the app (now wrapped in `ProviderScope` for Riverpod):
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: PlantPalApp()));
}
```
No widgets are built here.

## 8. Provider ✅ (already present, kept)
Still used for all feature controllers (auth, plants, cart, shop, etc.) and
for `SettingsController` (dark mode / notifications).

## 10. Caching ✅ (already present, wired to the new codegen model)
`core/cache/cache_manager.dart` was already a working cache-with-expiry
(memory + secure storage). `PlantRepositoryImpl` already read/wrote through
it; it now serializes/deserializes via `PlantDto` instead of the old manual
mapper.

## 11. Riverpod ✅ (new)
Added deliberately **alongside** Provider rather than replacing it, per the
requirement list asking for both:
- `core/locale/locale_controller.dart` — a `StateNotifier<Locale>` +
  `localeControllerProvider`, persisted to secure storage.
- `app/app.dart`'s `PlantPalApp` is now a `ConsumerStatefulWidget` so it can
  `ref.watch(localeControllerProvider)` for `MaterialApp.router`'s `locale`,
  while still using `MultiProvider`/`Consumer<SettingsController>` for theme.
- `SettingsScreen` is now a `ConsumerWidget` — the language picker calls
  `ref.read(localeControllerProvider.notifier).setLanguage(...)`.

## Setup after unzipping
```
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # regenerate *.g.dart
flutter run
```

## Known follow-ups (not done, scope-limited)
- Only Main Menu, Settings, Landing screen and the bottom nav are fully
  localized as a working demonstration; the remaining ~15 screens still have
  hardcoded English strings. Extending coverage is mechanical: add the key to
  the 2 `.arb` files + `AppLocalizations` + both language subclasses, then
  replace the literal string with `AppLocalizations.of(context).key`.
- Only `Plant`/`PlantDto` and `AuthUser` were converted to codegen models as
  a demonstrated pattern; other data-layer models can follow the same shape.
