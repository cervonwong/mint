/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controller/current_recipe_controller.dart';
import '../../../controller/recipe_catalogue_controller.dart';
import '../../../models/recipe.dart';
import '../../constants/color_constants.dart';
import '../../constants/theme_constants.dart';
import '../../shared_components/help_button.dart';
import '../../shared_components/listen_button.dart';
import '../../shared_components/shared_app_bars.dart';
import '../../utils/layout_calculator.dart';
import 'step_detail_screen.dart';

class RecipeCatalogueScreen extends StatefulWidget {
  static const routeName = 'home';

  RecipeCatalogueScreen();

  @override
  State<RecipeCatalogueScreen> createState() => _RecipeCatalogueScreenState();
}

class _RecipeCatalogueScreenState extends State<RecipeCatalogueScreen> {
  final ScrollController _scrollController = ScrollController();
  late List<Recipe> recipeList;

  @override
  Widget build(BuildContext context) {
    recipeList = Provider.of<RecipeCatalogueController>(context).recipeList;
    for (final recipe in recipeList) {
      assert(recipe.imageUrl != null);
    }

    return Scaffold(
      drawer: const Drawer(),
      extendBodyBehindAppBar: true,
      appBar: TitleRevealAppBar(
        scrollController: _scrollController,
        hasDrawer: true,
        title: 'My Recipes',
        actions: [
          const HelpButton(),
        ],
      ),
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
          _ResponsiveRecipeCardGrid(recipeList: recipeList),
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
                  RecipeCard(recipe: recipeList[i]),
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
                        if (i % 2 == 0) RecipeCard(recipe: recipeList[i]),
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
                        if (i % 2 == 1) RecipeCard(recipe: recipeList[i]),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.ivory200),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Material(
          color: ColorConstants.whitePrimary,
          borderRadius: BorderRadius.circular(12.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: () {
              // TODO: 10/30/2021 Have container transform transition between
              //  this screen and `StepDetailScreen`.
              Provider.of<CurrentRecipeController>(context, listen: false)
                  .selectRecipe(id: recipe.id);
              Navigator.pushNamed(context, StepDetailScreen.routeName);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  child: Image.network(
                    recipe.imageUrl!,
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
                        recipe.name,
                        style: ThemeConstants.headline6,
                      ),
                      const SizedBox(height: 12.0),
                      ListenButton(
                        id: recipe.id,
                        text: recipe.name,
                        labelType: LabelType.name,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
