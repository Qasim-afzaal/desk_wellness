import 'package:desk_wellness/app/app.dart';
import 'package:desk_wellness/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const ProviderScope(child: AffirmlyApp()));
}
