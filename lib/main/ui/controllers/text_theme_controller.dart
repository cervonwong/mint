/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:mint/main/ui/constants/color_constants.dart';
import 'layout_controller.dart';

class TextThemeController extends ChangeNotifier {
  TextStyle get headline1 => _headline1;
  late TextStyle _headline1;

  TextStyle get headline2 => _headline2;
  late TextStyle _headline2;

  TextStyle get headline3 => _headline3;
  late TextStyle _headline3;

  TextStyle get headline4 => _headline4;
  late TextStyle _headline4;

  TextStyle get headline5 => _headline5;
  late TextStyle _headline5;

  TextStyle get headline6 => _headline6;
  late TextStyle _headline6;

  TextStyle get subtitle7 => _subtitle7;
  late TextStyle _subtitle7; // subtitle1.

  TextStyle get subtitle8 => _subtitle8;
  late TextStyle _subtitle8; // subtitle2.

  TextStyle get body6 => _body6;
  late TextStyle _body6; // bodyText with size of headline6.

  TextStyle get body7 => _body7;
  late TextStyle _body7; // bodyText1.

  TextStyle get body8 => _body8;
  late TextStyle _body8; // bodyText2.

  TextStyle get body9 => _body9;
  late TextStyle _body9; // caption.

  TextStyle get body10 => _body10;
  late TextStyle _body10; // overline.

  TextStyle get button6 => _button6;
  late TextStyle _button6; // button with size of body6.

  TextStyle get button7 => _button7;
  late TextStyle _button7; // button with size of body7.

  TextStyle get button8 => _button8;
  late TextStyle _button8; // button.

  TextTheme get textTheme => _textTheme;
  late TextTheme _textTheme;

  final LayoutController _layoutController;

  TextThemeController({required LayoutController layoutController})
      : _layoutController = layoutController {
    layoutController.addListener(() {
      _updateFontSizes();
      _textTheme = _createTextTheme();
      notifyListeners();
    });
  }

  void _updateFontSizes() {
    final breakpoint = _layoutController.breakpoint;

    const String _redHatText = 'Red Hat Text';
    const String _redHatDisplay = 'Red Hat Display';
    const FontWeight _boldWeight = FontWeight.bold;
    const FontWeight _mediumWeight = FontWeight.w500;
    const FontWeight _regularWeight = FontWeight.w400;
    const double _globalFontSizeFactor = 1.0;
    const TextStyle baseTextStyle = TextStyle(
      color: ColorConstants.blackPrimary,
    );

    switch (breakpoint) {
      // Currently font size is not responsive.
      case LayoutBreakpoint.smallest:
      case LayoutBreakpoint.small:
      case LayoutBreakpoint.medium:
      case LayoutBreakpoint.large:
      case LayoutBreakpoint.largest:
        _headline1 = baseTextStyle.copyWith(
          fontFamily: _redHatDisplay,
          fontSize: 80.0 * _globalFontSizeFactor,
          fontWeight: _mediumWeight,
        );
        _headline2 = baseTextStyle.copyWith(
          fontFamily: _redHatDisplay,
          fontSize: 72.0 * _globalFontSizeFactor,
          fontWeight: _mediumWeight,
        );
        _headline3 = baseTextStyle.copyWith(
          fontFamily: _redHatDisplay,
          fontSize: 46.0 * _globalFontSizeFactor,
          fontWeight: _mediumWeight,
        );
        _headline4 = baseTextStyle.copyWith(
          fontFamily: _redHatDisplay,
          fontSize: 34.0 * _globalFontSizeFactor,
          fontWeight: _mediumWeight,
        );
        _headline5 = baseTextStyle.copyWith(
          fontFamily: _redHatDisplay,
          fontSize: 25.0 * _globalFontSizeFactor,
          fontWeight: _mediumWeight,
        );
        _headline6 = baseTextStyle.copyWith(
          fontFamily: _redHatDisplay,
          fontSize: 21.0 * _globalFontSizeFactor,
          fontWeight: _mediumWeight,
        );
        _subtitle7 = baseTextStyle.copyWith(
          fontFamily: _redHatText,
          fontSize: 17.0 * _globalFontSizeFactor,
          fontWeight: _mediumWeight,
        );
        _subtitle8 = baseTextStyle.copyWith(
          fontFamily: _redHatText,
          fontSize: 14.0 * _globalFontSizeFactor,
          fontWeight: _mediumWeight,
        );
        _body6 = baseTextStyle.copyWith(
          fontFamily: _redHatText,
          fontSize: 21.0 * _globalFontSizeFactor,
          fontWeight: _regularWeight,
        );
        _body7 = baseTextStyle.copyWith(
          fontFamily: _redHatText,
          fontSize: 17.0 * _globalFontSizeFactor,
          fontWeight: _regularWeight,
        );
        _body8 = baseTextStyle.copyWith(
          fontFamily: _redHatText,
          fontSize: 14.0 * _globalFontSizeFactor,
          fontWeight: _regularWeight,
        );
        _body9 = baseTextStyle.copyWith(
          fontFamily: _redHatText,
          fontSize: 12.0 * _globalFontSizeFactor,
          fontWeight: _regularWeight,
        );
        _body10 = baseTextStyle.copyWith(
          fontFamily: _redHatText,
          fontSize: 10.0 * _globalFontSizeFactor,
          fontWeight: _mediumWeight,
        );
        _button6 = baseTextStyle.copyWith(
          fontFamily: _redHatDisplay,
          fontSize: 21.0 * _globalFontSizeFactor,
          fontWeight: _boldWeight,
        );
        _button7 = baseTextStyle.copyWith(
          fontFamily: _redHatDisplay,
          fontSize: 17.0 * _globalFontSizeFactor,
          fontWeight: _boldWeight,
        );
        _button8 = baseTextStyle.copyWith(
          fontFamily: _redHatDisplay,
          fontSize: 14.0 * _globalFontSizeFactor,
          fontWeight: _boldWeight,
        );
    }
  }

  TextTheme _createTextTheme() {
    return TextTheme(
      headline1: _headline1,
      headline2: _headline2,
      headline3: _headline3,
      headline4: _headline4,
      headline5: _headline5,
      headline6: _headline6,
      subtitle1: _subtitle7,
      subtitle2: _subtitle8,
      bodyText1: _body7,
      bodyText2: _body8,
      caption: _body9,
      button: _button8,
      overline: _body10,
    );
  }
}
