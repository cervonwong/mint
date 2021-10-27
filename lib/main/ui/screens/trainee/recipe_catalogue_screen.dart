/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:mint/main/ui/constants/color_constants.dart';
import 'package:mint/main/ui/constants/theme_constants.dart';
import 'package:mint/main/ui/shared_components/listen_button.dart';
import 'package:mint/main/ui/shared_components/shared_app_bar.dart';
import 'package:mint/main/ui/utils/layout_calculator.dart';

class RecipeCatalogueScreen extends StatefulWidget {
  static const routeName = 'home';

  RecipeCatalogueScreen();

  @override
  State<RecipeCatalogueScreen> createState() => _RecipeCatalogueScreenState();
}

class _RecipeCatalogueScreenState extends State<RecipeCatalogueScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      extendBodyBehindAppBar: true,
      appBar: SharedAppBar(scrollController: _scrollController),
      body: ListView(
        controller: _scrollController,
        children: [
          SizedBox(height: 12.0),
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
          SizedBox(height: 16.0),
          RecipeCard(title: 'Fried Chicken Wings for Nasi Lemak'),
          RecipeCard(title: 'Fried Chicken Wings for Nasi Lemak'),
          RecipeCard(title: 'Fried Chicken Wings for Nasi Lemak'),
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
      padding: EdgeInsets.symmetric(
        horizontal: LayoutCalculator.margin(context: context),
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
            ClipRRect(
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
              padding: EdgeInsets.symmetric(
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
                  SizedBox(height: 12.0),
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
