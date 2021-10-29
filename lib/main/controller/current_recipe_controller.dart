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
  Recipe get currentRecipe => _currentRecipe;
  late Recipe _currentRecipe;

  Future<void> selectRecipe({required String id}) async {
    // TODO: 10/28/2021 Remember to uncomment the actual code and delete the placeholder code.
    // _currentRecipe = await _getRecipe(id: id);
    _currentRecipe = await _generatePlaceholderRecipe(id: id);

    notifyListeners();
  }
}

Future<Recipe> _getRecipe({required String id}) async {
  final collection = FirebaseFirestore.instance.collection('recipes');
  final querySnapshot = await collection.doc(id).get();

  final recipe = Recipe(
    id: '',
    // FIXME: 10/28/2021 Edited `Recipe`'s parameters, please fill the `id`
    //  argument above thanks :)
    steps: List<RecipeStep>.from(
      querySnapshot.data()!['steps'].map(
            (item) =>
                RecipeStep(instruction: item['step'], imageUrl: item['image']),
          ),
    ),
    name: '',
    // FIXME: 10/28/2021 Edited `Recipe`'s parameters, please fill the `name`
    //  argument above thanks :)
  );

  return recipe;
}

Future<Recipe> _generatePlaceholderRecipe({required String id}) async {
  final recipeName = id == 'chicken_wings'
      ? 'Chicken Wings'
      : id == 'chicken_wings_again'
          ? 'Chicken Wings Again'
          : id == 'more_chicken_wings'
              ? 'More Chicken Wings'
              : 'UNKNOWN ID? CHECK CODE';

  return Recipe(
    id: id,
    name: recipeName,
    steps: [
      RecipeStep(instruction: 'Placeholder Instruction 1 for $recipeName'),
      RecipeStep(instruction: 'Placeholder Instruction 2 for $recipeName'),
      RecipeStep(
        instruction: 'Placeholder Instruction 3 for $recipeName',
        imageUrl: 'PLACEHOLDER',
      ),
      RecipeStep(
        instruction: 'Placeholder Instruction 4 for $recipeName',
        imageUrl: 'PLACEHOLDER',
      ),
      RecipeStep(
        instruction: 'Placeholder Instruction 5 for $recipeName',
        imageUrl: 'PLACEHOLDER',
      ),
    ],
  );
}
