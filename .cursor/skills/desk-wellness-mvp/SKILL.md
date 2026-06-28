---
name: desk-wellness-mvp
description: >-
  Scaffold and extend the CalmCalibrate Riverpod MVP (desk_wellness): feature-first
  clean architecture, Drift SQLite, GetIt DI, GoRouter, offline-only wellness app.
  Use when adding screens, repositories, DB tables, onboarding steps, or matching
  this project's patterns. Reference sibling project calm_calibrate for content/assets.
---

# Desk Wellness MVP Pattern

Reference implementation: **CalmCalibrate** in `desk_wellness` — serverless Flutter MVP.

**Full spec:** [docs/PRODUCT_SPEC.md](../../../docs/PRODUCT_SPEC.md)  
**Sibling reference:** [calm_calibrate](../../calm_calibrate) (BLoC + go_router variant)

## When to use this skill

- Extending the Riverpod-based CalmCalibrate clone
- Adding onboarding steps, tabs, or push routes
- Adding Drift tables, repositories, or seed content
- Wiring notifications, AI service, or theme tokens

## Architecture (always follow)

```
Screen (ConsumerWidget) → Riverpod Provider → Repository → Drift (SQLite)
                              ↑
                         GetIt singletons (bootstrap)
```

- **Bootstrap:** `main.dart` → `configureDependencies()` → `DeskWellnessApp`
- **Routing:** `routerProvider` in `lib/app/router.dart` (GoRouter + redirect from `UserSettings.onboardingComplete`)
- **No backend:** Never add Firebase, Supabase, auth, or REST clients
- **Core widgets** must NOT import repositories directly — use Riverpod providers

## Stack differences vs calm_calibrate

| Concern | desk_wellness | calm_calibrate |
|---------|---------------|----------------|
| State | Riverpod | flutter_bloc |
| DI | GetIt | Manual singletons |
| Routes | GoRouter shell | go_router + BLoC |
| Package | `desk_wellness` | `calm_calibrate` |

Reuse **assets**, **exercise GIFs**, and **copy** from calm_calibrate when seeding content.

## Clone / new product checklist

| Step | Files |
|------|-------|
| Rename package | `pubspec.yaml`, Android `applicationId`, iOS bundle ID |
| Display name | `ios/Runner/Info.plist` CFBundleDisplayName |
| Brand | `lib/core/theme/app_theme.dart`, `assets/branding/` |
| Seed content | `lib/database/seed_data.dart` |
| Onboarding | `lib/features/onboarding/*`, routes in `router.dart` |
| DB schema | `lib/database/tables.dart` → bump `schemaVersion` |
| Codegen | `dart run build_runner build --delete-conflicting-outputs` |

## Add an onboarding screen

1. Create `lib/features/onboarding/my_step_screen.dart` as `ConsumerWidget` or `StatelessWidget`
2. Add route under `/onboarding/my-step` in `router.dart`
3. Wire `context.push('/onboarding/my-step')` from previous step
4. Persist via `SettingsRepository` if needed

## Add a feature screen

1. Folder: `lib/features/<feature>/`
2. Repository: `lib/repositories/<feature>_repository.dart`
3. Register in `lib/core/di/injection.dart`
4. Provider in `lib/shared/providers/repository_providers.dart`:

```dart
final myRepoProvider = Provider((ref) => getIt<MyRepository>());
```

5. Route in `router.dart` (tab branch or `GoRoute`)

## Add a Drift table

1. Define class in `lib/database/tables.dart`
2. Add to `@DriftDatabase(tables: [...])` in `app_database.dart`
3. Run build_runner
4. Add seed rows in `seed_data.dart` if needed
5. Bump `schemaVersion` + migration when shipping updates

**Naming:** Avoid column name `text` (conflicts with Drift API) — use `content`.

## Add repository method

```dart
class ExerciseRepository {
  ExerciseRepository(this._db);
  final AppDatabase _db;

  Stream<List<Exercise>> watchAll() => _db.select(_db.exercises).watch();
}
```

Use `Value(...)` for optional companion fields in inserts/updates.

## Notifications

- Service: `lib/core/services/notification_service.dart`
- v22 API uses **named parameters**: `settings:`, `id:`, `notificationDetails:`, `scheduledDate:`
- Request permission in onboarding before scheduling

## AI integration (later)

1. Extend `AIService` abstract class in `lib/core/services/ai_service.dart`
2. Implement provider-specific class (e.g. `GeminiAIService`)
3. Swap registration in `configureDependencies()`:

```dart
getIt.registerLazySingleton<AIService>(() => GeminiAIService(apiKey: ...));
```

UI must depend only on `AIService`.

## Design tokens

- Colors: `AppColors.light` / `.dark` via `ThemeExtension`
- Access: `context.colors.primary` (extension in `app_widgets.dart`)
- Cards: 20px radius, soft shadow, generous padding (16–24)

## Commands

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter run
```

## Do NOT

- Add login/signup flows
- Add cloud databases or sync (premium future)
- Import BLoC into this project unless migrating architecture
- Commit API keys — AI keys belong in secure storage when added later
