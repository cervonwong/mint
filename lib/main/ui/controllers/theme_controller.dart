/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mint/main/ui/constants/color_constants.dart';
import 'package:mint/main/ui/controllers/text_theme_controller.dart';

class ThemeController extends ChangeNotifier {
  ThemeData get themeData => _themeData;
  late ThemeData _themeData;

  ColorScheme get colorScheme => _colorScheme;
  ColorScheme _colorScheme = _createColorScheme();

  AppBarTheme get appBarTheme => _appBarTheme;
  late AppBarTheme _appBarTheme;

  ElevatedButtonThemeData get elevatedButton7ThemeData =>
      _elevatedButton7ThemeData;
  late ElevatedButtonThemeData _elevatedButton7ThemeData;

  IconThemeData get iconThemeData => _iconThemeData;
  IconThemeData _iconThemeData = _createIconThemeData();

  InputDecorationTheme get inputDecorationTheme => _inputDecorationTheme;
  late InputDecorationTheme _inputDecorationTheme;

  final TextThemeController _textThemeController;

  // CONSTRUCTOR
  ThemeController({required TextThemeController textThemeController})
      : _textThemeController = textThemeController {
    _textThemeController.addListener(() {
      _updateTextDependentThemes();
      _themeData = _createThemeData();
    });
  }

  void _updateTextDependentThemes() {
    _appBarTheme = _updateAppBarTheme();
    _elevatedButton7ThemeData = _updateElevatedButton7ThemeData();
    _inputDecorationTheme = _updateInputDecorationTheme();
  }

  ThemeData _createThemeData() {
    return ThemeData(
      // Essential ThemeData.
      colorScheme: colorScheme,

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
  }

  // TEXT INDEPENDENT STATIC THEME CREATION METHODS
  static ColorScheme _createColorScheme() {
    return ColorScheme(
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
  }

  static IconThemeData _createIconThemeData() {
    return IconThemeData(
      color: ColorConstants.greenPrimary,
    );
  }

  // TEXT DEPENDENT THEME UPDATING METHODS
  AppBarTheme _updateAppBarTheme() {
    return AppBarTheme(
      backgroundColor: ColorConstants.ivoryPrimary,
      foregroundColor: ColorConstants.blackPrimary,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  ElevatedButtonThemeData _updateElevatedButton7ThemeData() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          _textThemeController.button7,
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
  }

  InputDecorationTheme _updateInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: ColorConstants.greenOverlay,
      hintStyle: _textThemeController.body7.copyWith(
        color: ColorConstants.blackTertiary,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
