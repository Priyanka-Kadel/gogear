import 'package:flutter/material.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  _OnboardViewState createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  // Controller to manage PageView
  PageController _pageController = PageController();
  int _currentPage = 0;

  // Move to the next page
  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Skip to the Get Started page (directly to the last page)
  void _skip() {
    _pageController.jumpToPage(2); // Jump to the last page
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progress Indicator (Bar with Changing Points)
            _buildProgressIndicator(),
            // PageView for Onboarding Screens
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  // First Onboarding Screen
                  _buildOnboardingPage(
                    imagePath: 'assets/images/logo.png',
                    title: 'Welcome to GoGear',
                    description: 'Find and rent camping and trekking gear effortlessly.',
                    showSkipButton: true,
                    showNextButton: true,
                    onNextPressed: _nextPage,
                    onSkipPressed: _skip,
                  ),
                  // Second Onboarding Screen
                  _buildOnboardingPage(
                    imagePath: 'assets/images/logo.png',
                    title: 'Explore Gear Categories',
                    description: 'Discover a wide range of gear for your next adventure.',
                    showSkipButton: true,
                    showNextButton: true,
                    onNextPressed: _nextPage,
                    onSkipPressed: _skip,
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
                  ),
                ],
              ),
            ),
            // Navigation buttons with Progress Indicator in Between
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  // Progress Indicator (Dots) in the Center
  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: _currentPage == index ? Color(0xFFA8CD00) : Colors.grey,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }

  // Navigation Buttons (Skip and Next) with Progress Indicator in Between
  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip Button (only on first two pages)
          if (_currentPage < 2)
            TextButton(
              onPressed: _skip,
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          // Progress Indicator (centered between Skip and Next)
          Expanded(child: _buildProgressIndicator()),
          // Next Button (only on first two pages)
          if (_currentPage < 2)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA8CD00),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: _nextPage,
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
        ],
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
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 150,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 40),
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          description,
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        // Show Get Started Button in the center on the last page
        if (showGetStartedButton)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFA8CD00),
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'Get Started',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
      ],
    );
  }
}
