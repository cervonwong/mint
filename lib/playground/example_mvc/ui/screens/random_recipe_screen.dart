/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import '../components/random_recipe_button.dart';
import '../components/recipe_label.dart';

// Technically both `screens` and `components` are both widgets and they do not
// need to be seperated like this. But I like to keep them separate so I can
// clearly see all the "screens" in the app, and the components will be reusable
// between screens. :)
class RandomRecipeScreen extends StatelessWidget {
  const RandomRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              const Text('PLAYGROUND EXAMPLE TO DEMONSTRATE MVC ARCHITECTURE')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Random Recipe Generator! '
                '(This is not a functionality of the actual product)'),
            const SizedBox(height: 32.0),
            const RecipeLabel(),
            const SizedBox(height: 64.0),
            // This is usually how we add spacing between widgets.
            const RandomRecipeButton(),
          ],
        ),
      ),
    );
  }
}
