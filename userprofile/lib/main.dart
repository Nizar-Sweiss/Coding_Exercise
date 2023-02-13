import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/l10n/l10n.dart';
import 'package:userprofile/style/app_style.dart';
import 'package:userprofile/utility/utility_barrel.dart';
import 'utility/firebase/firebase_options.dart';

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
      scaffoldMessengerKey: Utils.messengerKey,
      theme: appThemeLight(),
      supportedLocales: L10n.all,
      localizationsDelegates: L10n.localizationsDelegates,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: RouteGenerator.launchHomeScreen(),
    );
  }
}
