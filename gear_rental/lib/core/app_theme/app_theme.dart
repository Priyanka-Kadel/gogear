import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 251, 251),
      fontFamily: 'Montserrat Regular',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat Bold'),
              backgroundColor: const Color(0xFFA8CD00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ))),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.black,
        elevation: 0,
        shadowColor: Colors.black,
      ));
}
