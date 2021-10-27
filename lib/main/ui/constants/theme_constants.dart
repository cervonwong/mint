/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_constants.dart';

class ThemeConstants {
  ThemeConstants._(); // Prevent instantiation with private constructor.

  // THEME DATA ===============================================================
  static final themeData = ThemeData(
    // Essential ThemeData.
    colorScheme: colorScheme,
    textTheme: textTheme,

    // Other themeData.
    appBarTheme: appBarTheme,
    elevatedButtonTheme: elevatedButton7ThemeData,
    iconTheme: iconThemeData,
    inputDecorationTheme: inputDecorationTheme,

    // Misc. arguments.
    scaffoldBackgroundColor: ColorConstants.ivoryPrimary,

    splashColor: ColorConstants.greenLightOverlay,
    highlightColor: ColorConstants.greenLightOverlay,
    hoverColor: ColorConstants.greenLightOverlay,
  );

  // COLOR SCHEME =============================================================

  static const colorScheme = ColorScheme(
    primary: ColorConstants.greenPrimary,
    primaryVariant: ColorConstants.greenDark,
    secondary: ColorConstants.ivoryPrimary,
    secondaryVariant: ColorConstants.ivory100,
    surface: ColorConstants.whitePrimary,
    background: ColorConstants.ivoryPrimary,
    error: ColorConstants.redPrimary,
    onPrimary: ColorConstants.whitePrimary,
    onSecondary: ColorConstants.blackPrimary,
    onSurface: ColorConstants.blackPrimary,
    onBackground: ColorConstants.blackPrimary,
    onError: ColorConstants.blackPrimary,
    brightness: Brightness.light,
  );

  // TEXT THEME ===============================================================
  static const String _redHatText = 'Red Hat Text';
  static const String _redHatDisplay = 'Red Hat Display';
  static const FontWeight _boldWeight = FontWeight.w700;
  static const FontWeight _mediumWeight = FontWeight.w500;
  static const FontWeight _regularWeight = FontWeight.w400;
  static const double _globalFontSizeFactor = 1.0;
  static final _baseTextStyle = const TextStyle(
    color: ColorConstants.blackPrimary,
  );

  static final textTheme = TextTheme(
    headline1: headline1,
    headline2: headline2,
    headline3: headline3,
    headline4: headline4,
    headline5: headline5,
    headline6: headline6,
    subtitle1: subtitle7,
    subtitle2: subtitle8,
    bodyText1: body7,
    bodyText2: body8,
    caption: body9,
    button: button8,
    overline: body10,
  );
  static final headline1 = _baseTextStyle.copyWith(
    fontFamily: _redHatDisplay,
    fontSize: 80.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  );
  static final headline2 = _baseTextStyle.copyWith(
    fontFamily: _redHatDisplay,
    fontSize: 72.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  );
  static final headline3 = _baseTextStyle.copyWith(
    fontFamily: _redHatDisplay,
    fontSize: 46.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  );
  static final headline4 = _baseTextStyle.copyWith(
    fontFamily: _redHatDisplay,
    fontSize: 34.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  );
  static final headline5 = _baseTextStyle.copyWith(
    fontFamily: _redHatDisplay,
    fontSize: 25.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  );
  static final headline6 = _baseTextStyle.copyWith(
    fontFamily: _redHatDisplay,
    fontSize: 21.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  );
  static final subtitle7 = _baseTextStyle.copyWith(
    fontFamily: _redHatText,
    fontSize: 17.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  );
  static final subtitle8 = _baseTextStyle.copyWith(
    fontFamily: _redHatText,
    fontSize: 14.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  );
  static final body6 = _baseTextStyle.copyWith(
    fontFamily: _redHatText,
    fontSize: 21.0 * _globalFontSizeFactor,
    fontWeight: _regularWeight,
  );
  static final body7 = _baseTextStyle.copyWith(
    fontFamily: _redHatText,
    fontSize: 17.0 * _globalFontSizeFactor,
    fontWeight: _regularWeight,
  );
  static final body8 = _baseTextStyle.copyWith(
    fontFamily: _redHatText,
    fontSize: 14.0 * _globalFontSizeFactor,
    fontWeight: _regularWeight,
  );
  static final body9 = _baseTextStyle.copyWith(
    fontFamily: _redHatText,
    fontSize: 12.0 * _globalFontSizeFactor,
    fontWeight: _regularWeight,
  );
  static final body10 = _baseTextStyle.copyWith(
    fontFamily: _redHatText,
    fontSize: 10.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  );
  static final button6 = _baseTextStyle.copyWith(
    fontFamily: _redHatDisplay,
    fontSize: 21.0 * _globalFontSizeFactor,
    fontWeight: _boldWeight,
  );
  static final button7 = _baseTextStyle.copyWith(
    fontFamily: _redHatDisplay,
    fontSize: 17.0 * _globalFontSizeFactor,
    fontWeight: _boldWeight,
  );
  static final button8 = _baseTextStyle.copyWith(
    fontFamily: _redHatDisplay,
    fontSize: 14.0 * _globalFontSizeFactor,
    fontWeight: _boldWeight,
  );

  // OTHER THEME DATA ARGUMENTS ===============================================

  static const appBarTheme = AppBarTheme(
    backgroundColor: ColorConstants.ivoryPrimary,
    foregroundColor: ColorConstants.blackPrimary,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  static final elevatedButton7ThemeData = ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(
        button7,
      ),
      elevation: MaterialStateProperty.all<double>(0.0),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      visualDensity: const VisualDensity(vertical: 2.0),
      foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return ColorConstants.blackSecondary;
        }
        return ColorConstants.whitePrimary;
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return ColorConstants.blackTertiary;
        }
        return ColorConstants.greenPrimary;
      }),
    ),
  );
  static const iconThemeData = IconThemeData(
    color: ColorConstants.greenPrimary,
  );
  static final inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: ColorConstants.greenOverlay,
    hintStyle: body7.copyWith(
      color: ColorConstants.blackTertiary,
    ),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12.0),
    ),
  );
}
