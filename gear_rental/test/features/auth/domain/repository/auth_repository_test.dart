import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../use_case/repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  group('AuthRepository Tests', () {
    test('should register user successfully', () async {
      // Arrange
      const AuthEntity user = AuthEntity(
          email: 'test@test.com', password: 'password', username: '');
      when(() => mockAuthRepository.registerUser(user))
          .thenAnswer((_) async => const Right(unit));

      // Act
      final result = await mockAuthRepository.registerUser(user);

      // Assert
      expect(result, const Right(unit));
      verify(() => mockAuthRepository.registerUser(user)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
