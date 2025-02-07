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
    test('ApiFailure equality based on message and statusCode', () {
      // Arrange
      const message1 = 'API request failed';
      const statusCode1 = 404;
      const message2 = 'Not found';
      const statusCode2 = 404;

      const failure1 = ApiFailure(statusCode1, message: message1);
      const failure2 = ApiFailure(statusCode1, message: message1);
      const failure3 = ApiFailure(statusCode2, message: message2);

      // Act & Assert
      expect(failure1, equals(failure2)); // Same message and statusCode
      expect(
          failure1, isNot(equals(failure3))); // Different message or statusCode
    });
  });
}
