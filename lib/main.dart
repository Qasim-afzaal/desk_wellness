import 'package:desk_wellness/app/app.dart';
import 'package:desk_wellness/core/di/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Prefer bundled/cached fonts; release builds must not hang/crash on network.
  GoogleFonts.config.allowRuntimeFetching = true;

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exceptionAsString()}');
  };

  try {
    await configureDependencies();
  } catch (e, st) {
    debugPrint('configureDependencies failed: $e\n$st');
  }

  runApp(const ProviderScope(child: AffirmationApp()));
}
