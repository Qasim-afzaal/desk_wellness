# CalmCalibrate (desk_wellness)

Premium offline-first wellness app for desk workers — Flutter MVP with Riverpod, GetIt, GoRouter, and Drift.

## Features

- Home dashboard (wellness score, streak, mood, affirmations, water)
- Office exercise library with timer sessions
- Guided breathing (animated circle)
- Mood tracker with weekly charts
- Journal with local SQLite storage
- Affirmations (create, favorite, categories)
- Local notification reminders
- Progress & achievements
- Profile (theme, privacy, reset)

**100% offline.** No auth, no backend, no Firebase.

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Docs

- [Product specification](docs/PRODUCT_SPEC.md)
- Cursor skill: `.cursor/skills/desk-wellness-mvp/SKILL.md`

## Architecture

```
lib/features/* → repositories → Drift (SQLite)
              ↑ Riverpod providers
              ↑ GetIt (bootstrap)
```

Reference implementation sibling: `../calm_calibrate` (BLoC variant).
