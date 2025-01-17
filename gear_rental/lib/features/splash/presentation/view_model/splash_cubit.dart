import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../onboarding/presentation/view/onboarding_view.dart';
import '../../../onboarding/presentation/view_model/onboarding_cubit.dart'; // Import OnboardingCubit

class SplashCubit extends Cubit<void> {
  SplashCubit(this._onboardingCubit) : super(null);

  final OnboardingCubit _onboardingCubit;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<OnboardingCubit>(
              create: (_) => _onboardingCubit,
              child: const OnboardView(), // Navigate to Onboarding
            ),
          ),
        );
      }
    });
  }
}
