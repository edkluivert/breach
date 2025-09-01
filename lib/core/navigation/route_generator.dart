// ignore_for_file: always_use_package_imports



import 'package:breach/core/navigation/route_paths.dart';
import 'package:breach/features/app_bottom_nav/presentation/pages/app_bottom_nav_screen.dart';
import 'package:breach/features/authentication/presentation/pages/login/login_screen.dart';
import 'package:breach/features/home/presentation/pages/interest_screen.dart';
import 'package:breach/features/authentication/presentation/pages/sign_up/sign_up_screen.dart';
import 'package:breach/features/authentication/presentation/pages/sign_up/welcome_screen.dart';
import 'package:breach/features/splash/presentation/pages/get_started_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow:  Container(),
      );
    case Routes.getStarted:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: GetStartedScreen(),
      );
    case Routes.signup:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpScreen(),
      );
    case Routes.login:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginScreen(),
      );
    case Routes.welcome:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: WelcomeScreen(),
      );
    // case Routes.interests:
    //   return _getPageRoute(
    //     routeName: settings.name,
    //     viewToShow: InterestScreen(
    //       onResult: (){},
    //     ),
    //   );
    case Routes.appBottomNav:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AppBottomNavScreen()
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

Route<void> _getPageRoute({
  String? routeName,
  Widget? viewToShow,
}) {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (context) => viewToShow!,
  );

  // return PageRoutes.platform(
  //   settings: RouteSettings(name: routeName),
  //   builder: (context) => viewToShow!,
  // );
}
