/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controller/random_recipe_controller.dart';

// To generate the template for a stateless widget, type "stless" and it will autogenerate a template.
class RecipeLabel extends StatelessWidget {
  const RecipeLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Consumers allow widgets to listen to controllers. The builder is such
    // that this stateless widget, can rebuild a part of itself when needed.
    return Consumer<RandomRecipeController>(
      builder: (_, controller, __) {
        return Text(
          '${controller.randomRecipe.name}',
          style: Theme.of(context).textTheme.headline2,
        );
      },
    );
  }
}
