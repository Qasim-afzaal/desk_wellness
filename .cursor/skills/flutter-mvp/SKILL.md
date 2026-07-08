---
name: flutter-mvp
description: >-
  Flutter MVP folder structure and Provider state management for offline apps.
  Use when scaffolding Kindled Studio-style apps, organizing lib/ with provider,
  or keeping features minimal without Riverpod/GetIt/codegen.
---

# Flutter MVP — Provider Pattern

Standard layout for an **MVP**: onboarding, tab shell, and a few push screens.  
Keep it flat. No code generation, no DI container until the product grows.

**Reference app:** Kindled Studio (`desk_wellness`) — affirmations, templates, editor, saved library.

---

## Folder structure

```
lib/
├── main.dart                 # runApp + MultiProvider setup
├── app.dart                  # MaterialApp, theme, routes
├── routes.dart               # route names + onGenerateRoute (or go_router)
│
├── core/
│   ├── theme/                # colors, text styles, ThemeData
│   ├── constants/            # asset paths, app name, static lists
│   └── widgets/              # shared buttons, cards, empty states
│
├── models/                   # plain Dart classes (no code gen)
│   ├── affirmation.dart
│   └── template.dart
│
├── services/                 # side effects (DB, notifications, share)
│   ├── database_service.dart
│   └── notification_service.dart
│
├── providers/                # ChangeNotifier classes + read helpers
│   ├── affirmation_provider.dart
│   ├── editor_provider.dart
│   └── settings_provider.dart
│
└── screens/                  # one file per screen (or screen + widgets/)
    ├── onboarding/
    │   └── welcome_screen.dart
    ├── today/
    │   └── today_screen.dart
    ├── templates/
    │   └── templates_screen.dart
    ├── editor/
    │   └── editor_screen.dart
    ├── saved/
    │   └── saved_screen.dart
    └── profile/
        └── profile_screen.dart
```

### Rules

| Do | Don't |
|----|--------|
| One screen ≈ one file under `screens/` | Deep `features/x/data/domain/presentation` early on |
| Models in `models/` as simple classes | Drift/codegen unless you need SQL |
| State in `providers/` | Business logic inside `build()` |
| Services called from providers | Screens calling `sqflite` directly |
| `core/widgets/` for reuse | Copy-paste the same card 4 times |

---

## Data flow

```
Screen → context.watch<EditorProvider>() → Provider → Service → local storage
                ↑
         ChangeNotifier.notifyListeners()
```

Screens **watch** state. They **read** providers for one-off actions (`context.read`).

---

## Bootstrap (`main.dart`)

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseService.open();

  runApp(
    MultiProvider(
      providers: [
        Provider<DatabaseService>.value(value: db),
        ChangeNotifierProvider(
          create: (ctx) => AffirmationProvider(ctx.read<DatabaseService>())..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => EditorProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SettingsProvider(ctx.read<DatabaseService>()),
        ),
      ],
      child: const KindledApp(),
    ),
  );
}
```

Add `provider: ^6.1.2` to `pubspec.yaml`. **Provider + ChangeNotifier** is the default for this MVP stack.

---

## Provider template

```dart
// lib/providers/affirmation_provider.dart
class AffirmationProvider extends ChangeNotifier {
  AffirmationProvider(this._db);
  final DatabaseService _db;

  List<Affirmation> _items = [];
  bool _loading = true;

  List<Affirmation> get items => _items;
  bool get loading => _loading;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    _items = await _db.getAffirmations();
    _loading = false;
    notifyListeners();
  }

  Future<void> add(String text) async {
    await _db.insertAffirmation(text);
    await load();
  }
}
```

---

## Screen template

```dart
// lib/screens/today/today_screen.dart
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AffirmationProvider>();

    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final today = provider.todayAffirmation;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Today', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              AffirmationCard(text: today?.text ?? 'Write your first affirmation'),
              const Spacer(),
              FilledButton(
                onPressed: () => Navigator.pushNamed(context, Routes.editor),
                child: const Text('Create wallpaper'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

Use `context.read<EditorProvider>()` inside callbacks (button `onPressed`), not in `build`.

---

## Routing

**Option A — named routes** (typical MVP):

```dart
// lib/routes.dart
abstract final class Routes {
  static const welcome = '/';
  static const home = '/home';
  static const editor = '/editor';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.welcome:
      return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    case Routes.home:
      return MaterialPageRoute(builder: (_) => const MainShell());
    case Routes.editor:
      return MaterialPageRoute(builder: (_) => const EditorScreen());
    default:
      return MaterialPageRoute(builder: (_) => const WelcomeScreen());
  }
}
```

**Option B — go_router** — when the project already uses it (see `desk-wellness-mvp` skill).

---

## Map Kindled Studio → MVP structure

| Current (full stack) | MVP (provider) |
|----------------------|----------------|
| `lib/features/today/` | `lib/screens/today/` |
| `lib/repositories/` | `providers/` + `services/database_service.dart` |
| `lib/shared/providers/` (Riverpod) | `lib/providers/` (ChangeNotifier) |
| `lib/core/di/injection.dart` (GetIt) | `MultiProvider` in `main.dart` |
| Drift + build_runner | `sqflite` or in-memory list |
| `editorDraftProvider` (StateProvider) | `EditorProvider extends ChangeNotifier` |

---

## Add a new screen (checklist)

1. Create `lib/screens/<name>/<name>_screen.dart`
2. Add route in `routes.dart`
3. If it needs data: add method on existing provider, or new `ChangeNotifier` in `providers/`
4. Register new provider in `main.dart` if needed
5. Wire navigation from previous screen

---

## Add local storage

```dart
// lib/services/database_service.dart
class DatabaseService {
  static Future<DatabaseService> open() async { /* sqflite open */ }

  Future<List<Affirmation>> getAffirmations() async { /* query */ }
  Future<void> insertAffirmation(String text) async { /* insert */ }
}
```

Keep SQL in **one** service file until tables grow; then split by table.

---

## When to upgrade

Move to Riverpod + repositories + Drift when:

- Screen count grows significantly
- Multiple developers need strict layers
- Complex async streams (many `watch()` queries)
- You need codegen migrations

Until then, stay on **Provider + services + screens**.

---

## Commands

```bash
flutter pub add provider
flutter analyze
flutter run
```

No `build_runner` required for this MVP pattern.

---

## Do NOT

- Mix GetIt + Riverpod + Provider in one MVP
- Add `domain/` and `data/` folders before you need them
- Put API keys or secrets in providers
- Call `notifyListeners()` before async work finishes without a loading flag
