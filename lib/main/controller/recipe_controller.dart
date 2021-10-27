/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/recipe.dart';
import '../models/step.dart';

class RecipeController extends ChangeNotifier {
  Recipe get recipe => _recipe;
  late Recipe _recipe;

  Future<void> requestRecipe({required String id}) async {
    _recipe = await _getRecipe(id: id);
    notifyListeners();
  }
}

Future<Recipe> _getRecipe({required String id}) async {
  final collection = FirebaseFirestore.instance.collection('recipes');
  final querySnapshot = await collection.doc(id).get();

  final recipe = Recipe(
    steps: List<Step>.from(
      querySnapshot.data()!['steps'].map(
            (item) => Step(step: item['step'], image: item['image']),
          ),
    ),
  );

  return recipe;
}
