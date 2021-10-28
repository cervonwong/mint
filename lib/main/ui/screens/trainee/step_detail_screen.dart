/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/rendering.dart';

import '../../constants/color_constants.dart';
import '../../constants/theme_constants.dart';
import '../../shared_components/listen_button.dart';
import '../../shared_components/shared_app_bars.dart';
import '../../shared_components/shared_buttons.dart';
import '../../utils/layout_calculator.dart';
import 'recipe_catalogue_screen.dart';

class StepDetailScreen extends StatefulWidget {
  static const routeName = 'steps';

  StepDetailScreen();

  @override
  State<StepDetailScreen> createState() => _StepDetailScreenState();
}

class _StepDetailScreenState extends State<StepDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: StepDetailAppBar(
        scrollController: _scrollController,
        onHomeButtonPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ExitRecipeConfirmationDialog();
            },
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutCalculator.wideMargin(context: context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: const StepCard(
                    instruction: 'Fry chicken wings for '
                        '8 minutes until golden brown.',
                  ),
                ),
              ),
            ),
            ElevatedButtonWithIcon7(
              onPressed: () {},
              icon: const Icon(FluentIcons.checkmark_24_regular),
              label: const Text('I have done step 3'),
            ),
            SizedBox(
              height: LayoutCalculator.breakpoint(context: context) ==
                      LayoutBreakpoint.smallest
                  ? 16.0
                  : 24.0,
            ),
          ],
        ),
      ),
    );
  }
}

class StepCard extends StatelessWidget {
  final String instruction;

  const StepCard({required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.whitePrimary,
        border: Border.all(color: ColorConstants.ivory200),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: const Image(
                image: AssetImage(
                  'assets/sample_images/Sample_RecipeCardThumbnail.png',
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  instruction,
                  style: ThemeConstants.headline6,
                ),
                const SizedBox(height: 12.0),
                ListenButton(
                  text: instruction,
                  labelType: LabelType.instruction,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExitRecipeConfirmationDialog extends StatelessWidget {
  const ExitRecipeConfirmationDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: IntrinsicWidth(
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: ThemeConstants.dividerGreenThemeData,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SelectableText(
                  'Are you sure you want to stop this recipe?',
                  style: ThemeConstants.headline5,
                ),
                const SizedBox(height: 24.0),
                ListenButton(
                  text:
                      'Are you sure you want to stop this recipe? <INSERT MORE EXPLANATION HERE>',
                  labelType: LabelType.message,
                ),
                const SizedBox(height: 32.0),
                const Divider(),
                const SizedBox(height: 16.0),
                TextButton7.error(
                  onPressed: () {
                    Navigator.pop(context); // Pop dialog.

                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      // Technically should not happen, unless in development.
                      Navigator.popAndPushNamed(
                          context, RecipeCatalogueScreen.routeName);
                    }
                  },
                  child: const Text('Stop recipe'),
                ),
                TextButton7(
                  onPressed: () {
                    Navigator.pop(context); // Pop dialog.
                  },
                  child: const Text('Continue recipe'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
