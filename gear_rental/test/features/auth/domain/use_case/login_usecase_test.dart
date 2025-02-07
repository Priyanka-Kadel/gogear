import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/domain/use_case/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  const testEmail = 'priyanka@gmail.com';
  const testPassword = 'priyanka123';
  const testToken = 'mocked_token';

  const loginParams = LoginParams(email: testEmail, password: testPassword);

  test('should return token on successful login', () async {
    // Arrange
    when(() => mockAuthRepository.loginUser(testEmail, testPassword))
        .thenAnswer((_) async => const Right(testToken));

    // Act
    final result = await loginUseCase(loginParams);

    // Assert
    expect(result, const Right(testToken));
    verify(() => mockAuthRepository.loginUser(testEmail, testPassword))
        .called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
