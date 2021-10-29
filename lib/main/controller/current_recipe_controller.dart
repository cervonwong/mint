/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/recipe.dart';
import '../models/recipe_step.dart';

// This controller allows UI to select what is the current recipe of interest.
// Then, the UI can access the `currentRecipe` to view its details.
// This controller fetches the name and steps (recipe image not needed for now)
// of the current recipe.
class CurrentRecipeController extends ChangeNotifier {
  Recipe? get currentRecipe => _currentRecipe; // Null if not initialised.
  Recipe? _currentRecipe;

  Future<void> selectRecipe({required String id}) async {
    _currentRecipe = await _getRecipe(id: id);

    notifyListeners();
  }
}

Future<Recipe> _getRecipe({required String id}) async {
  final collection = FirebaseFirestore.instance.collection('recipes');
  final querySnapshot = await collection.doc(id).get();

  final recipe = Recipe(
    id: querySnapshot.data()!['id'],
    steps: List<RecipeStep>.from(
      querySnapshot.data()!['steps'].map(
            (item) => RecipeStep(
                instruction: item['step'], imageUrl: item['imageUrl']),
          ),
    ),
    name: querySnapshot.data()!['name'],
  );

  return recipe;
}
