import 'package:flutter/material.dart';
import 'package:medicalaid/components/app_colors.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        fontFamily: 'GmarketSansTTF',
        textTheme: _textTheme,
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.white,
        appBarTheme: _appBarTheme,
        brightness: Brightness.light,
      );


  static ThemeData get darkTheme => ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        fontFamily: 'GmarketSansTTF',
        textTheme: _textTheme,
        splashColor: Colors.white,
        brightness: Brightness.dark,
      );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: AppColors.primaryColor,
    ),
    elevation: 0,
  );

  static const TextTheme _textTheme = TextTheme(
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
  );
}
