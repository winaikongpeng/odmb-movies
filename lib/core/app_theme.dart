import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData customTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.grey),
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: Colors.black),
      ),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.green),
      primarySwatch: Colors.grey,
      primaryColor: Colors.grey);
}
