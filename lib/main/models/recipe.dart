/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'dart:collection';

import 'package:meta/meta.dart';

import 'package:mint/main/models/step.dart';

@immutable
class Recipe {
  // UnmodifiableListView prevents list to be edited externally.
  UnmodifiableListView<Step> get steps => UnmodifiableListView(_steps);
  final List<Step> _steps;

  Recipe({required List<Step> steps}) : _steps = steps.toList();
}
