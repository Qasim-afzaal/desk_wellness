import 'package:desk_wellness/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await bootstrap();
  runApp(const ProviderScope(child: DeskWellnessApp()));
}
