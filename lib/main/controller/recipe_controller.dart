/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mint/main/models/recipe.dart';

import '../models/step.dart';

class RecipeController extends ChangeNotifier {
  late Recipe _recipe;

  get recipe => _recipe;

  Future<void> requestRecipe({id: String}) async {
    _recipe = await _getRecipe(id: id);
    notifyListeners();
  }
}

Future<Recipe> _getRecipe({id: String}) async {
  var collection = FirebaseFirestore.instance.collection('recipes');
  var querySnapshot = await collection.doc(id).get();

  Recipe recipe = new Recipe(
      steps: List<Step>.from(querySnapshot.data()!['steps'].map((item) {
    return new Step(step: item['step'], image: item['image']);
  })));

  return recipe;
}
