import 'package:cruise_buddy/UI/Screens/Auth/forgot_password_screen.dart';
import 'package:cruise_buddy/UI/Screens/Auth/login_screens.dart';
import 'package:cruise_buddy/UI/Screens/On%20Boarding/onboardingscreen_one.dart';
import 'package:cruise_buddy/UI/Screens/On%20Boarding/onboardingscreen_three.dart';
import 'package:cruise_buddy/UI/Screens/On%20Boarding/onboardingscreen_two.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static navigateToOnboardingOne(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreenOne()),
    );
  }

  static navigateToOnboardingTwo(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreenTwo()),
    );
  }

  static navigateToOnboardingThree(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreenThree()),
    );
  }

  static navigateToLoginScreen(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  static navigateToForgotPasswordScreen(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  ForgotPasswordScreen()),
    );
  }
}
