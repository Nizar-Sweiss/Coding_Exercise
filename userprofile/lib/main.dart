import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/screens/screens_barrel.dart';
import 'package:userprofile/style/style_barrel.dart';
import 'package:userprofile/utility/utility_barrel.dart';
import 'utility/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: light_blue_tint_2,
              iconSize: 40,
              splashColor: light_blue_tint_2),
          colorSchemeSeed: oxford_blue_tint_2,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: oxford_blue_tint_2,
          textTheme: const TextTheme(
            headline1: TextStyle(
                color: light_blue_tint_2,
                fontSize: 30,
                fontWeight: FontWeight.bold),
            headline2: TextStyle(
              color: light_blue_tint_2,
              fontSize: 25,
            ),
            headline3: TextStyle(
                color: light_blue_tint_2,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            bodyText2: TextStyle(color: oxford_blue_tint_1),
          )),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: ProfileInfoScreen(),
    );
  }
}
