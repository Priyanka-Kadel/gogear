import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_event.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_state.dart';
import 'package:mocktail/mocktail.dart';

// Mocks for dependencies
class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  group('LoginBloc', () {
    late MockLoginUseCase mockLoginUseCase;

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
    });

    // 1. Test Initial State
    test('should have initial state as LoginInitial', () {
      final loginBloc = LoginBloc(loginUseCase: mockLoginUseCase);
      expect(loginBloc.state, LoginInitial());
    });

    // 2. Test Login Success
    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login is successful',
      build: () => LoginBloc(loginUseCase: mockLoginUseCase),
      act: (bloc) {
        when(() => mockLoginUseCase.call(any()))
            .thenAnswer((_) async => Right(MockUser())); // Mock your use case
        bloc.add(
            const LoginEvent(username: 'validUser', password: 'validPassword'));
      },
      expect: () => [
        LoginLoading(),
        LoginSuccess(
            user: MockUser()) // Replace MockUser with a dummy or mocked user
      ],
    );

    // 3. Test Login Failure
    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] when login fails',
      build: () => LoginBloc(loginUseCase: mockLoginUseCase),
      act: (bloc) {
        when(() => mockLoginUseCase.call(any()))
            .thenAnswer((_) async => Left(MockFailure('Login Failed')));
        bloc.add(const LoginEvent(
            username: 'invalidUser', password: 'invalidPassword'));
      },
      expect: () => [LoginLoading(), LoginFailure(message: 'Login Failed')],
    );

    // 4. Test Login Loading State
    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading] when login event is triggered',
      build: () => LoginBloc(loginUseCase: mockLoginUseCase),
      act: (bloc) {
        bloc.add(
            const LoginEvent(username: 'anyUser', password: 'anyPassword'));
      },
      expect: () => [
        LoginLoading(),
      ],
    );

    // 5. Test Form Validation Error
    blocTest<LoginBloc, LoginState>(
      'emits [LoginFailure] when validation fails (empty username)',
      build: () => LoginBloc(loginUseCase: mockLoginUseCase),
      act: (bloc) {
        bloc.add(const LoginEvent(username: '', password: 'validPassword'));
      },
      expect: () => [
        LoginFailure(message: 'Username cannot be empty'),
      ],
    );
  });
}

// Mocked classes (you can replace these with your actual classes or mocks)
class MockUser {
  final String name = "Mock User";
  final String email = "mock@user.com";
}

class MockFailure {
  final String message;
  MockFailure(this.message);
}
