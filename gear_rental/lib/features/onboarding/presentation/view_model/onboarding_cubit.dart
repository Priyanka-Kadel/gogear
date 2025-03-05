import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:gear_rental/view/login_view.dart';

class OnboardingCubit extends Cubit<int> {
  final PageController pageController = PageController();
  final LoginBloc _loginBloc;

  OnboardingCubit(this._loginBloc) : super(0);

  /// Updates the current page index
  void updatePage(int page) {
    emit(page);
  }

  /// Moves to the next page in the onboarding process
  void nextPage() {
    if (state < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Skips to the last page of the onboarding process
  void skipToLast() {
    pageController.jumpToPage(2);
  }

  /// Navigates to the Login page after completing onboarding
  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _loginBloc,
          child: const LoginView(), // Navigate to Login
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
