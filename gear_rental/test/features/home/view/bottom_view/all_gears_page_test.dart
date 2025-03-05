import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/all_gears_page.dart';

void main() {
  testWidgets('AllGearsPage shows loading indicator when waiting for gadgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AllGearsPage()));

    // Check if loading indicator is shown while waiting
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('AllGearsPage displays gadget cards after data is loaded',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AllGearsPage()));

    // Simulate the future being completed
    await tester.pumpAndSettle();

    // Verify that gadget cards are displayed
    expect(find.byType(GearCard), findsWidgets);
  });
}
