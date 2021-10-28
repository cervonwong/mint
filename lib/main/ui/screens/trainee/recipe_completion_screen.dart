/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:mint/main/ui/constants/theme_constants.dart';
import 'package:mint/main/ui/screens/trainee/recipe_catalogue_screen.dart';
import 'package:mint/main/ui/utils/layout_calculator.dart';
import '../../shared_components/shared_buttons.dart';

class RecipeCompletionScreen extends StatelessWidget {
  static const routeName = 'recipe_completion';
  final String recipeName;

  // TODO: 10/28/2021 When logic implemented, recipeName should be retrieved
  //  from some controller which knows what the current recipe is.
  RecipeCompletionScreen() : recipeName = 'Fried Chicken Wings for Nasi Lemak';

  @override
  Widget build(BuildContext context) {
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
                      'You have completed $recipeName!',
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
