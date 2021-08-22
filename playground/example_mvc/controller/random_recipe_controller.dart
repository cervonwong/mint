/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/recipe.dart';

// The official, scant explanation of Providers and ChangeNotifiers:
// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple#changenotifier
// Idk what naming convention we want to use yet, but I guess naming like this:
// "FooController" looks legit.
class RandomRecipeController extends ChangeNotifier {
  // Putting a "_" in front of a variable name makes it private!!
  // It is private because this variable needs to change, but we don't want
  // other classes to change it directly. Hence we expose this variable using
  // getters.
  Recipe _randomRecipe;

  get randomRecipe => _randomRecipe;

  RandomRecipeController() : _randomRecipe = _generateRandomRecipe();

  // The UI widgets call this function.
  void requestRandomRecipe() {
    // In an actual app, this function would for example read recipes from a
    // database. Or maybe this function would write new data into the database
    // then inform listeners that they need to change the UI, etc.
    _randomRecipe = _generateRandomRecipe();
    notifyListeners(); // Triggers all UI widgets who are listening to this class to update their UI.
  }
}

// Yes, you can put functions outside of classes.
Recipe _generateRandomRecipe() {
// Yes, you can nest functions in functions.
  String generateRandomName() {
    final random = Random();
    const adjectives = ['Delicious', 'Chewy', 'Uncooked', 'Sour'];
    const mains = ['Steak', 'Chicken', 'Mouse', 'Cod'];
    const sides = ['Potatoes', 'Sticks', 'Grits', 'Tomatoes'];

    final adjective = adjectives[random.nextInt(adjectives.length)];
    final main = mains[random.nextInt(mains.length)];
    final side = sides[random.nextInt(sides.length)];

    return '$adjective $main with a side of $side';
  }

  return Recipe(name: generateRandomName());
}
