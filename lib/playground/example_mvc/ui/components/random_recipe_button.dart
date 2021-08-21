/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';
import 'package:mint/playground/example_mvc/controller/random_recipe_controller.dart';
import 'package:provider/provider.dart'; // Remember to import this :) Idk why it isnt automatically imported.

// To generate the template for a stateless widget, type "stless" and it will autogenerate a template.
class RandomRecipeButton extends StatelessWidget {
  const RandomRecipeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Consumers allow widgets to listen to controllers. The builder is such
    // that this stateless widget, can rebuild a part of itself when needed.
    return Consumer<RandomRecipeController>(
      builder: (_, controller, __) {
        return ElevatedButton(
          onPressed: () {
            controller.requestRandomRecipe();
          },
          child: Text('Generate random recipe!'),
        );
      },
    );
  }
}
