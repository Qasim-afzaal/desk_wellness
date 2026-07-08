---
name: desk-wellness-mvp
description: >-
  Scaffold and extend Kindled Studio (desk_wellness): affirmation & manifestation app
  with goals, templates, editor, wallpaper export, reminders, and saved library.
  Riverpod, GetIt, GoRouter, Drift SQLite, offline-only.
---

# Kindled Studio MVP Pattern

**Kindled Studio** — affirmation & manifestation app: goals → manifest → wallpaper → reminders.

## Architecture

```
Screen (ConsumerWidget) → Riverpod Provider → Repository → Drift (SQLite)
                              ↑
                         GetIt singletons (bootstrap)
```

## Main tabs

| Tab | Route | Purpose |
|-----|-------|---------|
| Today | `/today` | Goal-based daily affirmation, manifest CTA, stats |
| Templates | `/templates` | 16+ templates: calm, bold, manifest, abundance, love, focus |
| Saved | `/saved` | Bookmarked wallpapers |
| Profile | `/profile` | Goals, affirmation library, reminders, streak |

## Flows

**Onboarding:** `/onboarding/welcome` → `/onboarding/goals` → `/onboarding/reminders` → `/today`

**Manifest:** `/manifest` — 3-step guided session (goal → write → visualize → save/wallpaper)

**Create wallpaper:** `/templates/:id` → `/editor` → `/editor/style` → `/wallpaper/preview` → `/export`

**Affirmations:** `/affirmations` — browse, favorite, add custom, create wallpaper

Editor draft lives in `editorDraftProvider` (`AffirmationDraft`).

## Commands

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter run
```
