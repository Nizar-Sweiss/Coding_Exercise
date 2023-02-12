// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const oxford_blue_tint_1 = Color.fromARGB(255, 43, 52, 69);
const oxford_blue_tint_2 = Color.fromARGB(255, 48, 58, 76);
const oxford_blue_tint_3 = Color.fromARGB(255, 76, 92, 111);
const oxford_blue_tint_4 = Color.fromARGB(255, 66, 84, 102);
const oxford_blue_tint_5 = Color.fromARGB(255, 79, 92, 111);

const blue_tint_1 = Color.fromARGB(255, 76, 121, 255);
const blue_tint_2 = Color.fromARGB(255, 134, 154, 233);

const red_error = Color.fromARGB(255, 255, 15, 15);
const red_tint_1 = Color.fromARGB(255, 255, 74, 74);
const red_tint_2 = Color.fromARGB(255, 255, 186, 186);

const light_blue_tint_1 = Color.fromARGB(255, 123, 143, 177);
const light_blue_tint_2 = Color.fromARGB(255, 236, 242, 247);

const light_grey_tint_1 = Color.fromARGB(255, 184, 193, 202);

const light_green_tint_1 = Color.fromARGB(255, 210, 255, 206);
const light_yellow_tint_2 = Color.fromARGB(255, 250, 255, 190);
const light_green_tint_2 = Color.fromARGB(255, 14, 170, 0);

appTheme() {
  return ThemeData(
      iconTheme: const IconThemeData(
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
