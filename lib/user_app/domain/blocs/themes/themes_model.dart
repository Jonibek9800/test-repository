import 'package:eGrocer/user_app/domain/blocs/themes/themes_bloc.dart';
import 'package:flutter/material.dart';

/// light themes color
/// textColor = dark;
/// background = grey
/// blocks = white;

abstract class ThemeColor {
  static Color greenColor = const Color(0xFF56AE7C);
  static Color whiteColor = const Color(0xFFffffff);
  static Color darkColor = const Color(0xFF151A20);
  static Color blackColor = const Color(0xFF212934);
  static Color greyColor = const Color(0xFF808080);
}

class ThemesModel {
  /// Dark Theme
  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
        // color: ThemeColor.whiteColor,
        backgroundColor: ThemeColor.blackColor,
        iconTheme: IconThemeData(color: ThemeColor.whiteColor)),
    scaffoldBackgroundColor: ThemeColor.darkColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ThemeColor.blackColor,
      selectedItemColor: ThemeColor.greenColor,
      unselectedItemColor: ThemeColor.whiteColor,
    ),
    cardTheme: CardTheme(
      color: ThemeColor.blackColor,
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(ThemeColor.greenColor),
            textStyle: MaterialStatePropertyAll(
                TextStyle(color: ThemeColor.whiteColor)))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(ThemeColor.greyColor),
            textStyle: MaterialStatePropertyAll(
                TextStyle(color: ThemeColor.darkColor)))),
    useMaterial3: true,
  );

  /// Light Theme
  ThemeData lightTheme = ThemeData(
    iconTheme: IconThemeData(color: ThemeColor.greenColor),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(ThemeColor.greenColor),
            textStyle: MaterialStatePropertyAll(
                TextStyle(color: ThemeColor.darkColor)))),
    appBarTheme: AppBarTheme(
        // color: ThemeColor.whiteColor,
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: ThemeColor.darkColor)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(ThemeColor.greenColor),
            textStyle: MaterialStatePropertyAll(
                TextStyle(color: ThemeColor.darkColor)))),
    brightness: Brightness.light,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: ThemeColor.greenColor,
        unselectedItemColor: ThemeColor.greyColor,
        unselectedLabelStyle: TextStyle(color: ThemeColor.darkColor)),
    useMaterial3: true,
  );

  ThemesState? currentState = ThemesState.dark;
}
