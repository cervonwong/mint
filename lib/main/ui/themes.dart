/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mint/main/ui/constants/color_constants.dart';

final ThemeData kThemeData = ThemeData(
  // Essential ThemeData.
  colorScheme: colorScheme,
  textTheme: smallestTextTheme,
  // primaryTextTheme: smallestTextTheme,

  // Other themeData.
  appBarTheme: appBarTheme,

  // Misc. arguments.
  scaffoldBackgroundColor: ColorConstants.ivoryPrimary,
);

final ColorScheme colorScheme = ColorScheme(
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

const String _redHatText = 'Red Hat Text';
const String _redHatDisplay = 'Red Hat Display';
const FontWeight _boldWeight = FontWeight.bold;
const FontWeight _mediumWeight = FontWeight.w500;
const FontWeight _regularWeight = FontWeight.w400;
const double _globalFontSizeFactor = 1.0;
final TextTheme smallestTextTheme = TextTheme(
  headline1: TextStyle(
    fontFamily: _redHatDisplay,
    fontSize: 80.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  ),
  headline2: TextStyle(
    fontFamily: _redHatDisplay,
    fontSize: 72.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  ),
  headline3: TextStyle(
    fontFamily: _redHatDisplay,
    fontSize: 46.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  ),
  headline4: TextStyle(
    fontFamily: _redHatDisplay,
    fontSize: 34.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  ),
  headline5: TextStyle(
    fontFamily: _redHatDisplay,
    fontSize: 25.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  ),
  headline6: TextStyle(
    fontFamily: _redHatDisplay,
    fontSize: 21.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  ),
  subtitle1: TextStyle(
    fontFamily: _redHatText,
    fontSize: 17.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  ),
  subtitle2: TextStyle(
    fontFamily: _redHatText,
    fontSize: 14.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  ),
  bodyText1: TextStyle(
    fontFamily: _redHatText,
    fontSize: 17.0 * _globalFontSizeFactor,
    fontWeight: _regularWeight,
  ),
  bodyText2: TextStyle(
    fontFamily: _redHatText,
    fontSize: 14.0 * _globalFontSizeFactor,
    fontWeight: _regularWeight,
  ),
  caption: TextStyle(
    fontFamily: _redHatText,
    fontSize: 12.0 * _globalFontSizeFactor,
    fontWeight: _regularWeight,
  ),
  button: TextStyle(
    fontFamily: _redHatDisplay,
    fontSize: 14.0 * _globalFontSizeFactor,
    fontWeight: _boldWeight,
  ),
  overline: TextStyle(
    fontFamily: _redHatText,
    fontSize: 10.0 * _globalFontSizeFactor,
    fontWeight: _mediumWeight,
  ),
).apply(
  bodyColor: ColorConstants.blackPrimary,
  displayColor: ColorConstants.blackPrimary,
);

const AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: ColorConstants.ivoryPrimary,
  foregroundColor: ColorConstants.blackPrimary,
  elevation: 0.0,
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ),
);
