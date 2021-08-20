/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'ui/screens/random_recipe_screen.dart';

void main() {
  // The start of the application.
  runApp(ExampleMvcApp());
}

// Haha this is also a widget, everything is a widget.
class ExampleMvcApp extends StatelessWidget {
  const ExampleMvcApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomRecipeScreen(),
    );
  }
}
