/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'dart:collection';

import 'package:meta/meta.dart';

import 'recipe_step.dart';

@immutable
class RecipeStepDetails {
  final String recipeName;

  // UnmodifiableListView prevents list to be edited externally.
  UnmodifiableListView<RecipeStep> get steps => UnmodifiableListView(_steps);
  final List<RecipeStep> _steps;

  RecipeStepDetails({
    required this.recipeName,
    required List<RecipeStep> steps,
  }) : _steps = steps.toList();
}
