import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:gear_rental/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late RegisterUseCase registerUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUseCase = RegisterUseCase(mockAuthRepository);
  });

  const testEmail = 'test@example.com';
  const testUsername = 'testuser';
  const testPassword = 'password123';

  const registerParams = RegisterUserParams(
    email: testEmail,
    username: testUsername,
    password: testPassword,
  );

  const authEntity = AuthEntity(
    email: testEmail,
    username: testUsername,
    password: testPassword,
  );

  test('should register user successfully', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(authEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await registerUseCase(registerParams);

    // Assert
    expect(result, const Right(null));
    verify(() => mockAuthRepository.registerUser(authEntity)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
