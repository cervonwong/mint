/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/recipe.dart';

// This controller fetches the names and images of all recipes.
// (steps not necessary)
class RecipeCatalogueController extends ChangeNotifier {
  UnmodifiableListView<Recipe> get recipeList =>
      UnmodifiableListView(_recipeList);
  late List<Recipe> _recipeList;

  bool _hasInitialised = false;

  RecipeCatalogueController();

  // This function is called in the Provider in main.dart. This function will be
  // called once only.
  Future<void> initialise() async {
    // Make sure this function is not called when this controller already initialised.
    assert(_hasInitialised == false);

    // TODO: 10/28/2021 Replace with firebase logic below.
    _recipeList = await _generatePlaceholderRecipeList();
    _hasInitialised = true;
  }
}

Future<List<Recipe>> _generatePlaceholderRecipeList() async {
  return [
    Recipe(
      name: 'Chicken Wings',
      imageUrl: 'PLACEHOLDER',
    ),
    Recipe(
      name: 'Chicken Wings Again',
      imageUrl: 'PLACEHOLDER',
    ),
    Recipe(
      name: 'More Chicken Wings',
      imageUrl: 'PLACEHOLDER',
    ),
  ];
}
