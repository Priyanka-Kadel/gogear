import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/home/view/bottom_view/profile_page.dart';

void main() {
  testWidgets('ProfilePage shows user name and email',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

    // Check if user name and email are displayed
    expect(find.text('Username: testuser'), findsOneWidget);
    expect(find.text('Email: testuser@mail.com'), findsOneWidget);
  });

  testWidgets('ProfilePage shows logout button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

    // Verify if logout button exists
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
