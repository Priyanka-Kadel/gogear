import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/home/view/bottom_view/cart.dart';

void main() {
  testWidgets('CartPage shows empty message when cart is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartPage()));

    // Check for the empty cart message
    expect(find.text('Your cart is empty'), findsOneWidget);
  });

  testWidgets('CartPage shows items when cart is not empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartPage()));

    // Add an item to the cart
    await tester.tap(find.byIcon(Icons.add_shopping_cart));
    await tester.pumpAndSettle();

    // Verify if items are displayed in the cart
    expect(find.byType(CartItemWidget), findsWidgets);
  });
}
