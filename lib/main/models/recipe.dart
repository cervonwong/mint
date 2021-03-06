/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'dart:collection';

import 'package:meta/meta.dart';

import 'recipe_step.dart';

@immutable
class Recipe {
  final String id;
  final String name;

  // Can be null if this piece of info not needed.
  // E.g. the image of recipe not needed in the recipe instructions screen.
  final String? imageUrl;

  // UnmodifiableListView prevents list to be edited externally.
  // Can be null if this piece of info not needed.
  // E.g. the steps of recipe not needed in the catalogue screen.
  UnmodifiableListView<RecipeStep>? get steps {
    return _steps == null ? null : UnmodifiableListView(_steps!);
  }

  final List<RecipeStep>? _steps;

  Recipe({
    required this.id,
    required this.name,
    this.imageUrl,
    List<RecipeStep>? steps,
  }) : _steps = steps?.toList();
}
