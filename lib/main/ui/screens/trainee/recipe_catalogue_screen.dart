/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';
import '../../../models/recipe.dart';

import '../../constants/color_constants.dart';
import '../../constants/theme_constants.dart';
import '../../shared_components/listen_button.dart';
import '../../shared_components/shared_app_bar.dart';
import '../../utils/layout_calculator.dart';

class RecipeCatalogueScreen extends StatefulWidget {
  static const routeName = 'home';
  late final List<Recipe> recipeList;

  RecipeCatalogueScreen() {
    // TODO: 10/27/2021 When logic implemented, recipeList should be retrieved
    //  from some controller. Code in this constructor now is just a
    //  placeholder.
    recipeList = [
      Recipe(steps: []),
      Recipe(steps: []),
      Recipe(steps: []),
    ];
  }

  @override
  State<RecipeCatalogueScreen> createState() => _RecipeCatalogueScreenState();
}

class _RecipeCatalogueScreenState extends State<RecipeCatalogueScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      extendBodyBehindAppBar: true,
      appBar: SharedAppBar(scrollController: _scrollController),
      body: ListView(
        controller: _scrollController,
        children: [
          const SizedBox(height: 12.0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutCalculator.margin(context: context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  'Good afternoon, Andrea Lim!',
                  style: ThemeConstants.subtitle7.copyWith(
                    color: ColorConstants.blackSecondary,
                  ),
                ),
                SelectableText(
                  'My Recipes',
                  style: ThemeConstants.headline4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          _ResponsiveRecipeCardGrid(recipeList: widget.recipeList),
        ],
      ),
    );
  }
}

class _ResponsiveRecipeCardGrid extends StatelessWidget {
  final List<Recipe> recipeList;

  const _ResponsiveRecipeCardGrid({required this.recipeList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: LayoutCalculator.margin(context: context),
      ),
      child: LayoutCalculator.breakpoint(context: context) ==
              LayoutBreakpoint.smallest
          ? Column(
              children: [
                for (int i = 0; i < recipeList.length; i++)
                  RecipeCard(
                    title: 'Fried Chicken Wings for Nasi Lemak $i',
                  ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < recipeList.length; i++)
                        if (i % 2 == 0)
                          RecipeCard(
                            title: 'Fried Chicken Wings for Nasi Lemak $i',
                          ),
                    ],
                  ),
                ),
                const SizedBox(width: 32.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < recipeList.length; i++)
                        if (i % 2 == 1)
                          RecipeCard(
                            title: 'Fried Chicken Wings for Nasi Lemak $i',
                          ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;

  const RecipeCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.whitePrimary,
          border: Border.all(color: ColorConstants.ivory200),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image(
                image: AssetImage(
                  'assets/sample_images/Sample_RecipeCardThumbnail.png',
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: ThemeConstants.headline6,
                  ),
                  const SizedBox(height: 12.0),
                  ListenButton(
                    text: title,
                    labelType: LabelType.name,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
