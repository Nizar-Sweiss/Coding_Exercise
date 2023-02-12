// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:userprofile/style/app_colors.dart';

appTheme() {
  return ThemeData(
      iconTheme: const IconThemeData(
        color: AppColors.light_blue_tint_2,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.light_blue_tint_2,
          iconSize: 40,
          splashColor: AppColors.light_blue_tint_2),
      colorSchemeSeed: AppColors.oxford_blue_tint_2,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.oxford_blue_tint_2,
      textTheme: const TextTheme(
        headline1: TextStyle(
            color: AppColors.light_blue_tint_2,
            fontSize: 30,
            fontWeight: FontWeight.bold),
        headline2: TextStyle(
          color: AppColors.light_blue_tint_2,
          fontSize: 25,
        ),
        headline4: TextStyle(
          color: AppColors.oxford_blue_tint_1,
          fontSize: 20,
        ),
        headline3: TextStyle(
            color: AppColors.light_blue_tint_2,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        bodyText2: TextStyle(color: AppColors.oxford_blue_tint_1),
      ));
}
