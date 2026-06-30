# Kindled Studio

Daily affirmation app — write affirmations, customize templates, and turn them into wallpapers.

## Features

- **Today** — daily affirmation, streak, wallpaper count
- **Templates** — calm & bold design gallery
- **Editor** — write text, pick backgrounds, fonts, and layout
- **Wallpaper export** — preview lock screen, save to photos, share
- **Saved library** — bookmark and search your creations
- **Notifications** — morning, midday, and evening reminders
- **Profile** — streak, weekly rhythm chart, theme settings

**100% offline.** No auth, no backend.

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Architecture

```
lib/features/* → repositories → Drift (SQLite)
              ↑ Riverpod providers
              ↑ GetIt (bootstrap)
```

## Stack

Flutter · Riverpod · GetIt · GoRouter · Drift · gal (save to photos)
