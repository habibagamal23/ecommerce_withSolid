import 'package:go_router/go_router.dart';

import '../../features/Login/ui/screens/loginScreen.dart';
import '../../features/onboarding/onboardingscreen.dart';

class ConstantsRoutes {
  static const String splashScreen = "/";
  static const String loginScreen = "/login";
  static const String onBoardingScreen = "/onboard";
}

class AppRouter {
  static final GoRouter router =
      GoRouter(initialLocation: ConstantsRoutes.loginScreen, routes: [
    // login
    GoRoute(
      path: ConstantsRoutes.loginScreen,
      builder: (context, state) {
        return const Loginscreen();
      },
    ),
    GoRoute(
      path: ConstantsRoutes.onBoardingScreen,
      builder: (context, state) {
        return const OnboardingScreen();
      },
    ),
  ]);
}
