import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dataforge_flutter/main.dart';

void main() {
  testWidgets('App starts and shows home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app bar is present
    expect(find.text('DataForge Challenge'), findsOneWidget);

    // Verify that bottom navigation is present
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('Navigation between tabs works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find the bottom navigation bar
    final bottomNav = find.byType(BottomNavigationBar);
    expect(bottomNav, findsOneWidget);

    // Tap on second tab
    await tester.tap(find.text('Serverpod Data'));
    await tester.pumpAndSettle();

    // Verify tab content is shown
    expect(find.text('Users'), findsOneWidget);
  });
}
