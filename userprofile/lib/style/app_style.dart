// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const oxford_blue_tint_1 = Color.fromARGB(255, 43, 52, 69); //2B3445
const oxford_blue_tint_2 = Color.fromARGB(255, 48, 58, 76); //303A4C
const oxford_blue_tint_3 = Color.fromARGB(255, 76, 92, 111); //4C5C6F
const oxford_blue_tint_4 = Color.fromARGB(255, 66, 84, 102); //425466
const oxford_blue_tint_5 = Color.fromARGB(255, 79, 92, 111); //4F5C6F

const blue_tint_1 = Color.fromARGB(255, 76, 121, 255); //4C79FF
const blue_tint_2 = Color.fromARGB(255, 134, 154, 233); //869AE9

const red_tint_1 = Color.fromARGB(255, 255, 74, 74); //FF4A4A
const red_tint_2 = Color.fromARGB(255, 255, 186, 186); //FFBABA

const light_blue_tint_1 = Color.fromARGB(255, 123, 143, 177); //7B8FB1
const light_blue_tint_2 = Color.fromARGB(255, 236, 242, 247); // ECF2F7

const light_grey_tint_1 = Color.fromARGB(255, 184, 193, 202); //B8C1E0

const light_green_tint_1 = Color.fromARGB(255, 210, 255, 206); //D2FFCE
const light_yellow_tint_2 = Color.fromARGB(255, 250, 255, 190); //FAFFBE
const light_green_tint_2 = Color.fromARGB(255, 14, 170, 0);

appTheme() {
  return ThemeData(
      iconTheme: IconThemeData(
        color: light_blue_tint_2,
      ),
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
        headline4: TextStyle(
          color: oxford_blue_tint_1,
          fontSize: 20,
        ),
        headline3: TextStyle(
            color: light_blue_tint_2,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        bodyText2: TextStyle(color: oxford_blue_tint_1),
      ));
}
