import 'package:flutter/material.dart';
import 'package:wuskan/ui/onboarding/ui/onboarding.dart';


abstract class MainNavigationRoutes {
  static const String main = '/';
  static const String onboarding = '/onboarding';
}

final routes = {
  MainNavigationRoutes.main: (BuildContext context) => OnBoardingScreen(),
  MainNavigationRoutes.onboarding: (BuildContext context) =>
  const OnBoardingScreen(),
};