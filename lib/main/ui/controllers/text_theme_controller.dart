/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:mint/main/ui/constants/color_constants.dart';
import 'layout_controller.dart';

// TODO: 10/11/2021 Can scrap this class if not used at the end.  And replace with constants.
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

  bool _hasInitialised = false;
  LayoutBreakpoint? _currentBreakpoint;

  TextThemeController({required LayoutController layoutController})
      : _layoutController = layoutController {
    layoutController.addListener(() {
      if (_hasInitialised) return;
      if (_currentBreakpoint == layoutController.breakpoint) return;
      _updateFontSizes();
      _textTheme = _createTextTheme();
      notifyListeners();
      _hasInitialised = true;
    });
  }

  void _updateFontSizes() {
    final breakpoint = _layoutController.breakpoint;

    const String redHatText = 'Red Hat Text';
    const String redHatDisplay = 'Red Hat Display';
    const FontWeight boldWeight = FontWeight.w700;
    const FontWeight mediumWeight = FontWeight.w500;
    const FontWeight regularWeight = FontWeight.w400;
    const double globalFontSizeFactor = 1.0;
    const TextStyle baseTextStyle = TextStyle(
      color: ColorConstants.blackPrimary,
    );

    late double breakpointSizeFactor = 1.0;

    switch (breakpoint) {
      // Currently font size is not responsive. // Does it need to be?
      case LayoutBreakpoint.smallest:
      case LayoutBreakpoint.small:
      case LayoutBreakpoint.medium:
      case LayoutBreakpoint.large:
      case LayoutBreakpoint.largest:
        break;
    }

    _headline1 = baseTextStyle.copyWith(
      fontFamily: redHatDisplay,
      fontSize: 80.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: mediumWeight,
    );
    _headline2 = baseTextStyle.copyWith(
      fontFamily: redHatDisplay,
      fontSize: 72.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: mediumWeight,
    );
    _headline3 = baseTextStyle.copyWith(
      fontFamily: redHatDisplay,
      fontSize: 46.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: mediumWeight,
    );
    _headline4 = baseTextStyle.copyWith(
      fontFamily: redHatDisplay,
      fontSize: 34.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: mediumWeight,
    );
    _headline5 = baseTextStyle.copyWith(
      fontFamily: redHatDisplay,
      fontSize: 25.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: mediumWeight,
    );
    _headline6 = baseTextStyle.copyWith(
      fontFamily: redHatDisplay,
      fontSize: 21.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: mediumWeight,
    );
    _subtitle7 = baseTextStyle.copyWith(
      fontFamily: redHatText,
      fontSize: 17.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: mediumWeight,
    );
    _subtitle8 = baseTextStyle.copyWith(
      fontFamily: redHatText,
      fontSize: 14.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: mediumWeight,
    );
    _body6 = baseTextStyle.copyWith(
      fontFamily: redHatText,
      fontSize: 21.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: regularWeight,
    );
    _body7 = baseTextStyle.copyWith(
      fontFamily: redHatText,
      fontSize: 17.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: regularWeight,
    );
    _body8 = baseTextStyle.copyWith(
      fontFamily: redHatText,
      fontSize: 14.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: regularWeight,
    );
    _body9 = baseTextStyle.copyWith(
      fontFamily: redHatText,
      fontSize: 12.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: regularWeight,
    );
    _body10 = baseTextStyle.copyWith(
      fontFamily: redHatText,
      fontSize: 10.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: mediumWeight,
    );
    _button6 = baseTextStyle.copyWith(
      fontFamily: redHatDisplay,
      fontSize: 21.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: boldWeight,
    );
    _button7 = baseTextStyle.copyWith(
      fontFamily: redHatDisplay,
      fontSize: 17.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: boldWeight,
    );
    _button8 = baseTextStyle.copyWith(
      fontFamily: redHatDisplay,
      fontSize: 14.0 * globalFontSizeFactor * breakpointSizeFactor,
      fontWeight: boldWeight,
    );
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

  @override
  void dispose() {}
}
