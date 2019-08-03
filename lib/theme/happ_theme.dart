import 'package:flutter/material.dart';

class HappTheme {
  ThemeData get lightTheme => ThemeData.light().copyWith(
        accentColor: accentColor,
      );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        accentColor: accentColor,
      );

  MaterialColor get accentColor => Colors.blue;
}
