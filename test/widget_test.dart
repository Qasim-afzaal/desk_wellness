import 'package:desk_wellness/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App boots to welcome or home', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: DeskWellnessApp()));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
