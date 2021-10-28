/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/recipe_step.dart';
import '../models/recipe_step_details.dart';

class RecipeController extends ChangeNotifier {
  RecipeStepDetails get recipe => _recipe;
  late RecipeStepDetails _recipe;

  Future<void> requestRecipe({required String id}) async {
    _recipe = await _getRecipe(id: id);
    notifyListeners();
  }
}

Future<RecipeStepDetails> _getRecipe({required String id}) async {
  final collection = FirebaseFirestore.instance.collection('recipes');
  final querySnapshot = await collection.doc(id).get();

  final recipe = RecipeStepDetails(
    steps: List<RecipeStep>.from(
      querySnapshot.data()!['steps'].map(
            (item) =>
                RecipeStep(instruction: item['step'], imageUrl: item['image']),
          ),
    ),
    recipeName: '',
    // FIXME: 10/28/2021 Edited `RecipeStepDetail`'s
    //  parameters, please fill the `name` argument above thanks :)
  );

  return recipe;
}
