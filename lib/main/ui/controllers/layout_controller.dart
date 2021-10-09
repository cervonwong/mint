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
  late double _width;

  double get margin => _margin;
  late double _margin;

  LayoutBreakpoint get breakpoint => _breakpoint;
  late LayoutBreakpoint _breakpoint;

  LayoutController();

  void updateWidth(double width) {
    _width = width;
    _breakpoint = _calculateBreakpoint();
    _margin = _calculateMargin();

    notifyListeners();
  }

  LayoutBreakpoint _calculateBreakpoint() {
    if (_width < 600.0)
      return LayoutBreakpoint.smallest;
    else if (_width < 905.0)
      return LayoutBreakpoint.small;
    else if (_width < 1240.0)
      return LayoutBreakpoint.medium;
    else if (_width < 1440.0)
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
        return (_width - 840.0) / 2;
      case LayoutBreakpoint.large:
        return 200.0;
      case LayoutBreakpoint.largest:
        return (_width - 1040.0) / 2;
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
