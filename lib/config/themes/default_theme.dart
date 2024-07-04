// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';

ThemeData defaultTheme = ThemeData(
  primaryColor: primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(bodyTextColor),
    minimumSize: MaterialStateProperty.all(
      Size.fromHeight(52),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(29.0),
    )),
    backgroundColor: MaterialStateProperty.all(primaryColor),
  )),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      // fixedSize: MaterialStateProperty.all(
      //   Size.fromHeight(6),
      // ),
    ),
  ),
  tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(fontSize: 18),
      unselectedLabelStyle: TextStyle(fontSize: 18)),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: iconColorWhite),
      backgroundColor: appbarBackgroundColor,
      titleTextStyle: TextStyle(color: textColor)),
  textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          fontSize: 24, color: Colors.white, fontWeight: FontWeight.w900),
      displaySmall: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal),
      headlineSmall: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
          fontSize: 16, color: bodyTextColor, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: bodyTextColor,
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(fontSize: 14, color: subtitleColor)),
  iconTheme: IconThemeData(color: Colors.white),
  primaryIconTheme: IconThemeData(color: Colors.white),
);
