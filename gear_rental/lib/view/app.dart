import 'package:flutter/material.dart';

import 'dashboard_view.dart';
import 'login_view.dart';
import 'onboard_view.dart';
import 'signup_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoGear',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/onboarding': (context) => OnboardView(),
        '/login': (context) => LoginView(),
        '/signup': (context) => SignupView(),
        '/dashboard': (context) => DashboardView(),
      },
    );
  }
}
