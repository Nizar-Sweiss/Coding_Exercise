// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:userprofile/style/app_colors.dart';

appThemeLight() {
  return ThemeData(
    iconTheme: _iconThemeData(),
    floatingActionButtonTheme: _floatingActionButtonThemeData(),
    colorSchemeSeed: AppColors.oxford_blue_tint_2,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.oxford_blue_tint_2,
    textTheme: _textThemeData(),
  );
}

IconThemeData _iconThemeData() {
  return const IconThemeData(
    color: AppColors.light_blue_tint_2,
  );
}

FloatingActionButtonThemeData _floatingActionButtonThemeData() {
  return const FloatingActionButtonThemeData(
      backgroundColor: AppColors.light_blue_tint_2,
      iconSize: 40,
      splashColor: AppColors.light_blue_tint_2);
}

TextTheme _textThemeData() {
  return const TextTheme(
    displayLarge: TextStyle(
        color: Color.fromARGB(255, 249, 249, 249),
        fontSize: 30,
        fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
      color: AppColors.light_blue_tint_2,
      fontSize: 25,
    ),
    headlineMedium: TextStyle(
      color: AppColors.oxford_blue_tint_1,
      fontSize: 20,
    ),
    displaySmall: TextStyle(
        color: AppColors.light_blue_tint_2,
        fontSize: 20,
        fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: AppColors.oxford_blue_tint_1),
  );
}
