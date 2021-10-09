/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

/// Handles calculating UI spacing constants that depend on size of application
/// window.
///
/// For example, UI elements will listen to this and determine what layout is
/// appropriate and what is the width of the margins
class LayoutController extends ChangeNotifier {
  double get screenWidth => _screenWidth;
  late double _screenWidth;

  LayoutBreakpoint get breakpoint => _breakpoint;
  late LayoutBreakpoint _breakpoint;

  double get margin => _margin;
  late double _margin;

  /// Used instead of [margin] when content is in a single column, to prevent
  /// text from becoming too long.
  double get wideMargin => _wideMargin;
  late double _wideMargin;

  LayoutController();

  void updateScreenWidth(double screenWidth) {
    _screenWidth = screenWidth;
    _breakpoint = _calculateBreakpoint();
    _margin = _calculateMargin();
    _wideMargin = _calculateWideMargin();

    notifyListeners();
  }

  LayoutBreakpoint _calculateBreakpoint() {
    if (_screenWidth < 600.0)
      return LayoutBreakpoint.smallest;
    else if (_screenWidth < 905.0)
      return LayoutBreakpoint.small;
    else if (_screenWidth < 1240.0)
      return LayoutBreakpoint.medium;
    else if (_screenWidth < 1440.0)
      return LayoutBreakpoint.large;
    else
      return LayoutBreakpoint.largest;
  }

  double _calculateMargin() {
    switch (_breakpoint) {
      case LayoutBreakpoint.smallest:
        return 16.0;
      case LayoutBreakpoint.small:
        return 32.0;
      case LayoutBreakpoint.medium:
        return (_screenWidth - 840.0) / 2;
      case LayoutBreakpoint.large:
        return 200.0;
      case LayoutBreakpoint.largest:
        return (_screenWidth - 1040.0) / 2;
    }
  }

  double _calculateWideMargin() {
    switch (_breakpoint) {
      case LayoutBreakpoint.smallest:
        return 16.0;
      case LayoutBreakpoint.small:
        return (_screenWidth - 400.0) / 2;
      case LayoutBreakpoint.medium:
        return (_screenWidth - 600.0) / 2; // Placeholder value.
      case LayoutBreakpoint.large:
        return (_screenWidth - 600.0) / 2; // Placeholder value.
      case LayoutBreakpoint.largest:
        return (_screenWidth - 600.0) / 2; // Placeholder value.
    }
  }
}

// The relative size of the app window wrt to the width of the app window.
enum LayoutBreakpoint {
  smallest, // Approx. width of Phone.
  small, // Approx. width of Small Tablet or Landscape Phone.
  medium, // Approx. width of Tablet.
  large, // Approx. width of Laptop.
  largest, // Approx. width of Desktop.
}
