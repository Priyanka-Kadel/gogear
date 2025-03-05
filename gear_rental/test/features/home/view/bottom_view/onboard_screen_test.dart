import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/home/view/bottom_view/onboard_screen.dart';

void main() {
  testWidgets('OnboardingPage shows "Get Started" button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingPage()));

    // Check if the "Get Started" button exists
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets(
      'OnboardingPage navigates to Dashboard when Get Started is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingPage()));

    // Simulate pressing the Get Started button
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify navigation to DashboardPage
    expect(find.byType(DashboardPage), findsOneWidget);
  });
}
