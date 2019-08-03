import 'package:flutter/material.dart';

class HappTheme {
  ThemeData get lightTheme => ThemeData.light().copyWith(
        accentColor: accentColor,
        scaffoldBackgroundColor: Color(0xffdddddd),
        cardColor: Color(0xffeeeeee),
        indicatorColor: accentColor,
      );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        accentColor: accentColorMuted,
        scaffoldBackgroundColor: Color(0xff111111),
        cardColor: Color(0xff222222),
        indicatorColor: accentColorMuted,
      );

  Color get accentColor => Color(0xff4444aa);
  Color get accentColorMuted => Color(0xff6666ff);
}
