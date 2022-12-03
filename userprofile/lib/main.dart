import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/screens/screens_barrel.dart';
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
    return const MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: ProfileInfoScreen(),
    );
  }
}
