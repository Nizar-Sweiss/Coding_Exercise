import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/models/user.dart';
import 'package:userprofile/screens/screens_barrel.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const ProfileInfoScreen());
      case '/editProfile':
        User userData = settings.arguments as User;

        return MaterialPageRoute(
            builder: (_) => EditProfileScreen(
                  userData: (userData),
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 135, 7, 7),
          ),
          body: const Center(
            child: Icon(
              Icons.error,
              size: 100,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        );
      },
    );
  }
}
