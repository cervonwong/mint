/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controller/current_recipe_controller.dart';
import '../../constants/theme_constants.dart';
import '../../shared_components/shared_buttons.dart';
import '../../utils/layout_calculator.dart';
import 'recipe_catalogue_screen.dart';

class RecipeCompletionScreen extends StatelessWidget {
  static const routeName = 'trainee/complete';

  RecipeCompletionScreen();

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<CurrentRecipeController>(context).currentRecipe!;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutCalculator.wideMargin(context: context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Image(
                      width: 360.0,
                      height: 240.0,
                      image: AssetImage(
                        'assets/illustrations/Crab_WooHoo.png',
                      ),
                    ),
                    SelectableText(
                      'Well done!',
                      textAlign: TextAlign.center,
                      style: ThemeConstants.headline3,
                    ),
                    const SizedBox(height: 24.0),
                    SelectableText(
                      'You have completed ${recipe.name}!',
                      textAlign: TextAlign.center,
                      style: ThemeConstants.headline6,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton7(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  // Technically should not happen, unless in development.
                  Navigator.popAndPushNamed(
                      context, RecipeCatalogueScreen.routeName);
                }
              },
              child: const Text('Continue'),
            ),
            SizedBox(
              height: LayoutCalculator.bottomButtonBottomMargin(
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
