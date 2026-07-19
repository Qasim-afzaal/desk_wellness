import 'package:desk_wellness/app/router.dart';
import 'package:desk_wellness/core/widgets/app_widgets.dart';
import 'package:desk_wellness/shared/providers/repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AffirmationApp extends ConsumerWidget {
  const AffirmationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final settings = ref.watch(settingsStreamProvider);

    final themeMode = settings.maybeWhen(
      data: (s) => switch (s.themeMode) {
        'dark' => ThemeMode.dark,
        'light' => ThemeMode.light,
        _ => ThemeMode.system,
      },
      orElse: () => ThemeMode.system,
    );

    return MaterialApp.router(
      title: 'Affirmation',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(brightness: Brightness.light),
      darkTheme: buildAppTheme(brightness: Brightness.dark),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
