import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthEntity Tests', () {
    test(
        'AuthEntity equality should be based on userId, email, username, and password',
        () {
      // Arrange
      const userId1 = '1';
      const email1 = 'test1@test.com';
      const username1 = 'testuser1';
      const password1 = 'password1';

      const userId2 = '2';
      const email2 = 'test2@test.com';
      const username2 = 'testuser2';
      const password2 = 'password2';

      const authEntity1 = AuthEntity(
        userId: userId1,
        email: email1,
        username: username1,
        password: password1,
      );
      const authEntity2 = AuthEntity(
        userId: userId1,
        email: email1,
        username: username1,
        password: password1,
      );
      const authEntity3 = AuthEntity(
        userId: userId2,
        email: email2,
        username: username2,
        password: password2,
      );

      // Act & Assert
      expect(authEntity1, equals(authEntity2)); // Same values for all fields
      expect(authEntity1,
          isNot(equals(authEntity3))); // Different values for some fields
    });

    test(
        'AuthEntity props should contain userId, email, username, and password',
        () {
      // Arrange
      const userId = '1';
      const email = 'test@test.com';
      const username = 'testuser';
      const password = 'password';

      const authEntity = AuthEntity(
        userId: userId,
        email: email,
        username: username,
        password: password,
      );

      // Act & Assert
      expect(authEntity.props, [userId, email, username, password]);
    });
  });
}
