import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/onboarding_cubit.dart';
// import '../../../auth/presentation/view/login_view.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = BlocProvider.of<OnboardingCubit>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // PageView for Onboarding Screens
            Expanded(
              child: PageView(
                controller: onboardingCubit.pageController,
                onPageChanged: onboardingCubit.updatePage,
                children: [
                  // First Onboarding Screen
                  _buildOnboardingPage(
                    imagePath: 'assets/images/logo.png',
                    title: 'Welcome to GoGear',
                    description:
                        'Find and rent camping and trekking gear effortlessly.',
                    showSkipButton: true,
                    showNextButton: true,
                    onNextPressed: onboardingCubit.nextPage,
                    onSkipPressed: onboardingCubit.skipToLast,
                  ),
                  // Second Onboarding Screen
                  _buildOnboardingPage(
                    imagePath: 'assets/images/logo.png',
                    title: 'Explore Gear Categories',
                    description:
                        'Discover a wide range of gear for your next adventure.',
                    showSkipButton: true,
                    showNextButton: true,
                    onNextPressed: onboardingCubit.nextPage,
                    onSkipPressed: onboardingCubit.skipToLast,
                  ),
                  // Final Onboarding Screen (Get Started page)
                  _buildOnboardingPage(
                    imagePath: 'assets/images/logo.png',
                    title: 'Get Started',
                    description: 'Start your adventure with GoGear now!',
                    showSkipButton: false,
                    showNextButton: false,
                    onNextPressed: null,
                    onSkipPressed: null,
                    showGetStartedButton: true,
                    onGetStartedPressed: () {
                      onboardingCubit.navigateToLogin(context);
                    },
                  ),
                ],
              ),
            ),
            // Navigation buttons with Progress Indicator at the bottom
            _buildNavigationButtons(onboardingCubit),
          ],
        ),
      ),
    );
  }

  // Navigation Buttons (Skip and Next) with Progress Indicator in Between
  Widget _buildNavigationButtons(OnboardingCubit onboardingCubit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          // Progress Indicator (dots)
          BlocBuilder<OnboardingCubit, int>(
            builder: (context, state) {
              return _buildProgressIndicator(onboardingCubit, state);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip Button (only on first two pages)
              BlocBuilder<OnboardingCubit, int>(
                builder: (context, state) {
                  return state < 2
                      ? TextButton(
                          onPressed: onboardingCubit.skipToLast,
                          child: const Text(
                            'Skip',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
              // Next Button (only on first two pages)
              BlocBuilder<OnboardingCubit, int>(
                builder: (context, state) {
                  return state < 2
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA8CD00),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: onboardingCubit.nextPage,
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Progress Indicator (Dots) at the Bottom
  Widget _buildProgressIndicator(
      OnboardingCubit onboardingCubit, int currentPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return GestureDetector(
            onTap: () => onboardingCubit.pageController.jumpToPage(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? const Color(0xFFA8CD00)
                    : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }

  // Onboarding Page Layout
  Widget _buildOnboardingPage({
    required String imagePath,
    required String title,
    required String description,
    bool showSkipButton = false,
    bool showNextButton = false,
    VoidCallback? onNextPressed,
    VoidCallback? onSkipPressed,
    bool showGetStartedButton = false,
    VoidCallback? onGetStartedPressed,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 150,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 40),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        // Show Get Started Button in the center on the last page
        if (showGetStartedButton)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA8CD00),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: onGetStartedPressed,
            child: const Text(
              'Get Started',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
      ],
    );
  }
}
