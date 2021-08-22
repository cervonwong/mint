/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

@immutable // Annotation to check that all class variables are final. i.e. immutable.
class Recipe {
  final String name; // Getters and setters are implicit. Dart creates getters
  // and setters for you already, only write them if you want to override default
  // getter and setter.

  // Shortform way to write constructor with one named and required parameter.
  Recipe({required this.name});
}

// Example of how you would instantiate a `Recipe`:
// This is analog to `public static void main(String[] args)`
void main() {
  final recipe = Recipe(name: 'Steak');
  // Notice that:
  // - the `new` keyword is not required.
  // - you are required to specify the name of the parameter (you can change the
  //     constructor in `Recipe` to make it not require named parameters, but
  //     I feel this makes things clearer).
  print(recipe);
}
