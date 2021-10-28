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

  RecipeCatalogueController() {
    // Initialise _recipeList.
    // TODO: 10/28/2021 Some firebase logic here. The code in this constructor
    //  will be run when this class created for the first time. (This class will
    //  be a singleton so this code is only called once throughout one app
    //  usage session)
  }

  // No other code needed for now.
}
