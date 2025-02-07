import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/core/error/failure.dart';

void main() {
  group('Failure Class Tests', () {
    test('LocalDatabaseFailure should have correct message and props', () {
      // Arrange
      const message = 'Database failure';
      const failure = LocalDatabaseFailure(message: message);

      // Act & Assert
      expect(failure.message, message);
      expect(failure.props, [message]);
    });
  });
}
