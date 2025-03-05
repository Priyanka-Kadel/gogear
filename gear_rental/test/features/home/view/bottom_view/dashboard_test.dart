import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/home/view/bottom_view/all_gears_page.dart';

void main() {
  testWidgets('DashboardPage has AppBar with correct title',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardPage()));

    // Verify if the title of the AppBar is displayed
    expect(find.text('Dashboard'), findsOneWidget);
  });

  testWidgets('DashboardPage navigates to AllGearsPage when gear is clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardPage()));

    // Tap on a gear item
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();

    // Verify that AllGearsPage is displayed after navigation
    expect(find.byType(AllGearsPage), findsOneWidget);
  });
}
