import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:gear_rental/features/auth/presentation/view_model/signup/register_event.dart';
import 'package:gear_rental/features/auth/presentation/view_model/signup/register_state.dart';
import 'package:mocktail/mocktail.dart';

// Mocks for dependencies
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

void main() {
  group('RegisterBloc', () {
    late MockRegisterUseCase mockRegisterUseCase;

    setUp(() {
      mockRegisterUseCase = MockRegisterUseCase();
    });

    // 1. Test Initial State
    test('should have initial state as RegisterInitial', () {
      final registerBloc = RegisterBloc(registerUseCase: mockRegisterUseCase);
      expect(registerBloc.state, RegisterInitial());
    });

    // 2. Test Register Success
    blocTest<RegisterBloc, RegisterState>(
      'emits [RegisterLoading, RegisterSuccess] when registration is successful',
      build: () => RegisterBloc(registerUseCase: mockRegisterUseCase),
      act: (bloc) {
        when(() => mockRegisterUseCase.call(any())).thenAnswer(
            (_) async => Right(MockUser())); // Mock the successful registration
        bloc.add(
            RegisterEvent(username: 'validUser', password: 'validPassword'));
      },
      expect: () => [
        RegisterLoading(),
        RegisterSuccess(
            user: MockUser()) // Replace MockUser with a dummy or mocked user
      ],
    );

    // 3. Test Register Failure
    blocTest<RegisterBloc, RegisterState>(
      'emits [RegisterLoading, RegisterFailure] when registration fails',
      build: () => RegisterBloc(registerUseCase: mockRegisterUseCase),
      act: (bloc) {
        when(() => mockRegisterUseCase.call(any()))
            .thenAnswer((_) async => Left(MockFailure('Registration Failed')));
        bloc.add(RegisterEvent(
            username: 'invalidUser', password: 'invalidPassword'));
      },
      expect: () =>
          [RegisterLoading(), RegisterFailure(message: 'Registration Failed')],
    );

    // 4. Test Register Loading State
    blocTest<RegisterBloc, RegisterState>(
      'emits [RegisterLoading] when registration event is triggered',
      build: () => RegisterBloc(registerUseCase: mockRegisterUseCase),
      act: (bloc) {
        bloc.add(RegisterEvent(username: 'anyUser', password: 'anyPassword'));
      },
      expect: () => [
        RegisterLoading(),
      ],
    );

    // 5. Test Form Validation Error
    blocTest<RegisterBloc, RegisterState>(
      'emits [RegisterFailure] when validation fails (empty username)',
      build: () => RegisterBloc(registerUseCase: mockRegisterUseCase),
      act: (bloc) {
        bloc.add(RegisterEvent(username: '', password: 'validPassword'));
      },
      expect: () => [
        RegisterFailure(message: 'Username cannot be empty'),
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
