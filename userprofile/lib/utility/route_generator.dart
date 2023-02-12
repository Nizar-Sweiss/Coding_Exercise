import 'package:flutter/material.dart';
import 'package:userprofile/models/user.dart';
import 'package:userprofile/screens/error_route_screen.dart';
import 'package:userprofile/screens/screens_barrel.dart';

class RouteGenerator {
  static RouteSettings routeSettings = const RouteSettings();
  static Widget homeScreen = const ProfileInfoScreen();

  static launchHomeScreen() {
    return RouteGenerator.homeScreen;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    setRouteSettings(settings);
    return navigateToPage();
  }

  static Route<dynamic> navigateToPage() {
    switch (routeSettings.name) {
      case '/':
        return homePage();
      case '/editPrsssofile':
        return editProfileScreenPage();
      default:
        return _errorRoutePage();
    }
  }

  static void setRouteSettings(RouteSettings settings) {
    routeSettings = settings;
  }

  static MaterialPageRoute<dynamic> editProfileScreenPage() {
    User userData = routeSettings.arguments as User;

    return MaterialPageRoute(
      builder: (_) => EditProfileScreen(
        userData: (userData),
      ),
    );
  }

  static MaterialPageRoute<dynamic> homePage() =>
      MaterialPageRoute(builder: (_) => RouteGenerator.launchHomeScreen());

  static Route<dynamic> _errorRoutePage() {
    return MaterialPageRoute(
      builder: (_) {
        return const ErrorRouteScreen();
      },
    );
  }
}
