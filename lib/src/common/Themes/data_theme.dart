// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../hex_color.dart';

class AppTheme {
  static final TextTheme textTheme = TextTheme(
    headline1: _headLine1,
    headline2: _headLine2,
    headline3: _headLine3,
    headline4: _headLine4,
    headline5: _headLine5,
    headline6: _headLine6,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
    subtitle1: _subTitle1,
    subtitle2: _subTitle2,
    caption: _caption,
  );

  static const TextStyle _headLine1 =
      TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold);

  static final TextStyle _headLine2 = _headLine1.copyWith();
  static final TextStyle _headLine3 = _headLine2.copyWith();
  static final TextStyle _headLine4 = _headLine3.copyWith();
  static final TextStyle _headLine5 = _headLine4.copyWith();
  static final TextStyle _headLine6 =
      _headLine5.copyWith(fontFamily: 'Akrobat');
  static final TextStyle _subTitle1 = _headLine6.copyWith();
  static final TextStyle _subTitle2 = _subTitle1.copyWith();
  static final TextStyle _bodyText1 = _subTitle2.copyWith();
  static final TextStyle _bodyText2 = _bodyText1.copyWith();
  static final TextStyle _caption = _bodyText2.copyWith();

  static ThemeData themeData(bool ligthMode) {
    return ThemeData(
        primaryColor: HexColor("#3f888f"),
        primaryColorDark: HexColor("#054855"),
        primaryColorLight: HexColor("#5d8aa8"),
        tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.grey,
            labelColor: ligthMode ? HexColor("#3f888f") : Colors.white),
        colorScheme: ColorScheme(
          primary: HexColor("#3f888f"),
          primaryVariant: HexColor("#5d8aa8"),
          secondary: HexColor("#054855"),
          secondaryVariant: HexColor("#387a91"),
          surface: Colors.white,
          background: Colors.white70,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: const Color.fromRGBO(43, 45, 66, 1),
          onSurface: const Color.fromRGBO(43, 45, 66, 1),
          onBackground: const Color.fromRGBO(43, 45, 66, 1),
          onError: Colors.white,
          brightness: ligthMode ? Brightness.dark : Brightness.light,
        ),
        textTheme: textTheme);
  }
}
