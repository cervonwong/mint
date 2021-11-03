/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
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
import 'name_selection_screen.dart';
import 'recipe_instructions_screen.dart';

class RecipeCatalogueScreen extends StatefulWidget {
  static const routeName = 'trainee/home';

  RecipeCatalogueScreen();

  @override
  State<RecipeCatalogueScreen> createState() => _RecipeCatalogueScreenState();
}

class _RecipeCatalogueScreenState extends State<RecipeCatalogueScreen> {
  final ScrollController _scrollController = ScrollController();
  late List<Recipe> recipeList;
  bool titleFaded = false;
  static const double fadeOffset = 30.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final fadeCriteria = _scrollController.offset > fadeOffset;
      if (fadeCriteria != titleFaded) {
        setState(() {
          titleFaded = fadeCriteria;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    recipeList = Provider.of<RecipeCatalogueController>(context).recipeList;
    for (final recipe in recipeList) {
      assert(recipe.imageUrl != null);
    }

    return Scaffold(
      drawerScrimColor: ColorConstants.ivoryScrim,
      drawer: const _RecipeCatalogueScreenDrawer(),
      extendBodyBehindAppBar: true,
      appBar: TitleRevealAppBar(
        scrollController: _scrollController,
        hasDrawer: true,
        title: 'My Recipes',
        actions: [
          const HelpButton(
            id: 'Help',
            text: 'This is the home screen. Do you see the pictures on the '
                'screen? If you want to learn how to make a dish, press the '
                'picture of the dish to see the recipe. Remember, if you get '
                'lost or need help, you can press this question mark icon!',
          ),
        ],
        revealOffset: fadeOffset,
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          const SizedBox(height: 12.0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutCalculator.margin(context: context),
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: titleFaded ? 0.0 : 1.0,
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
          ),
          const SizedBox(height: 16.0),
          _ResponsiveRecipeCardGrid(recipeList: recipeList),
        ],
      ),
    );
  }
}

class _RecipeCatalogueScreenDrawer extends StatelessWidget {
  const _RecipeCatalogueScreenDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorConstants.ivoryPrimary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                style: ThemeConstants.textButton7ThemeData.style,
                child: const Text('Sign out'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    NameSelectionScreen.routeName,
                    (route) => false,
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: OpenContainer(
        routeSettings:
            const RouteSettings(name: RecipeInstructionsScreen.routeName),
        closedColor: ColorConstants.whitePrimary,
        openColor: ColorConstants.ivoryPrimary,
        middleColor: ColorConstants.ivoryPrimary,
        transitionType: ContainerTransitionType.fadeThrough,
        closedElevation: 0.0,
        openElevation: 0.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        transitionDuration: const Duration(milliseconds: 600),
        closedBuilder: (context, closedBuilder) {
          return Container(
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
                  closedBuilder();
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
          );
        },
        openBuilder: (context, _) {
          Provider.of<CurrentRecipeController>(context, listen: false)
              .selectRecipe(id: recipe.id);
          return RecipeInstructionsScreen();
        },
      ),
    );
  }
}
