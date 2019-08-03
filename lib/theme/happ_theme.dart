import 'package:flutter/material.dart';

class HappTheme {
  ThemeData get lightTheme => ThemeData.light().copyWith(
        accentColor: accentColor,
        scaffoldBackgroundColor: Color(0xffdddddd),
        cardColor: Color(0xffeeeeee)
      );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        accentColor: accentColor,
        scaffoldBackgroundColor: Color(0xff111111),
        cardColor: Color(0xff222222),
      );

  MaterialColor get accentColor => Colors.blue;
}
