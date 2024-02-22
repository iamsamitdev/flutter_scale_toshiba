import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/colors.dart';

class AppTheme {
  // Light theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'NotoSansThai',
    useMaterial3: false,
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: primaryDark,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: icons),
    scaffoldBackgroundColor: icons,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'NotoSansThai',
      ),
      backgroundColor: primary,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    )
  );
}