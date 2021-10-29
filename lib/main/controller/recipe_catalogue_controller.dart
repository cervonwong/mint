/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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

    _recipeList = await _getRecipeList();
    _hasInitialised = true;
  }
}

Future<List<Recipe>> _getRecipeList() async {
  var snapshot = await FirebaseFirestore.instance.collection('recipes').get();
  var recipesIterable = snapshot.docs.map((doc) => doc.data());
  var recipes = <Recipe>[];
  recipesIterable.forEach((recipe) {
    recipes.add(Recipe(
      id: recipe['id'],
      name: recipe['name'],
      imageUrl: recipe['imageUrl'],
    ));
  });

  return recipes;
}
