/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mint/main/ui/constants/color_constants.dart';

final ThemeData kThemeData = ThemeData(
  // Essential ThemeData.
  colorScheme: colorScheme,

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

const AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: ColorConstants.ivoryPrimary,
  foregroundColor: ColorConstants.blackPrimary,
  elevation: 0.0,
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ),
);
