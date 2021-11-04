/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';

import '../../../controller/current_recipe_controller.dart';
import '../../constants/color_constants.dart';
import '../../constants/theme_constants.dart';
import '../../shared_components/listen_button.dart';
import '../../shared_components/shared_app_bars.dart';
import '../../shared_components/step_card.dart';
import '../../utils/layout_calculator.dart';
import 'recipe_catalogue_screen.dart';
import 'recipe_completion_screen.dart';

class RecipeInstructionsScreen extends StatefulWidget {
  static const routeName = 'trainee/recipe/instructions';

  RecipeInstructionsScreen();

  @override
  State<RecipeInstructionsScreen> createState() =>
      _RecipeInstructionsScreenState();
}

class _RecipeInstructionsScreenState extends State<RecipeInstructionsScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int currentStepIndex = 0;
  int currentStepNumber = 1; // To prevent miscounting. Number = Index + 1.

  late final AnimationController animationController;
  late final Animation<double> oldCardRotationAngle;
  late final Animation<double> newCardRotationAngle;

  @override
  void initState() {
    super.initState();

    animationController = StepCard.generateAnimationController(this);
    oldCardRotationAngle =
        StepCard.getOldCardRotationAngle(animationController);
    newCardRotationAngle =
        StepCard.getNewCardRotationAngle(animationController);
    animationController.forward();
  }

  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierColor: ColorConstants.ivoryScrim,
      builder: (context) {
        return const ExitConfirmationDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<CurrentRecipeController>(context).currentRecipe;
    if (recipe == null) {
      return Container();
    }
    final steps = recipe.steps!;

    return WillPopScope(
      onWillPop: () async {
        await _showExitConfirmationDialog(context);
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: RecipeInstructionsScreenAppBar(
          scrollController: _scrollController,
          recipeName: recipe.name,
          currentStepNumber: currentStepNumber,
          totalStepCount: steps.length,
          onHomeButtonPressed: () {
            _showExitConfirmationDialog(context);
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, _) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              LayoutCalculator.wideMargin(context: context),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.translate(
                              offset: StepCard.generateNewCardTranslationOffset(
                                context,
                                animationController,
                              ).value,
                              child: Transform.rotate(
                                angle: newCardRotationAngle.value,
                                child: StepCard(
                                  borderColor: ColorConstants.ivory200,
                                  instruction:
                                      steps[currentStepIndex].instruction,
                                  imageUrl: steps[currentStepIndex].imageUrl,
                                ),
                              ),
                            ),
                            Container(
                              child: currentStepIndex == 0
                                  ? null
                                  : Transform.translate(
                                      offset: StepCard
                                          .generateOldCardTranslationOffset(
                                        context,
                                        animationController,
                                      ).value,
                                      child: Transform.rotate(
                                        angle: oldCardRotationAngle.value,
                                        child: StepCard(
                                          borderColor: ColorConstants.ivory200,
                                          instruction:
                                              steps[currentStepIndex - 1]
                                                  .instruction,
                                          imageUrl: steps[currentStepIndex - 1]
                                              .imageUrl,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: LayoutCalculator.wideMargin(context: context),
              ),
              child: ElevatedButton.icon(
                style: ThemeConstants.elevatedButton7ThemeData.style,
                onPressed: () {
                  if (steps.length == currentStepNumber) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RecipeCompletionScreen.routeName,
                      (route) => false,
                    );
                  } else {
                    setState(() {
                      currentStepIndex++;
                      currentStepNumber++;
                    });
                    animationController.reset();
                    animationController.forward();
                  }
                },
                icon: const Icon(FluentIcons.checkmark_24_regular),
                label: const Text('Done'),
              ),
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

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: const Duration(milliseconds: 500),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550.0),
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectableText(
                  'Back to Home Screen?',
                  textAlign: TextAlign.center,
                  style: ThemeConstants.headline5,
                ),
                const SizedBox(height: 12.0),
                SelectableText(
                  'If you leave this recipe, you will have to restart '
                  'this recipe the next time.',
                  textAlign: TextAlign.center,
                  style: ThemeConstants.body7.copyWith(
                    color: ColorConstants.blackSecondary,
                  ),
                ),
                const SizedBox(height: 24.0),
                ListenButton(
                  id: 'Instruction',
                  text:
                      'Do you want to go back to the home screen? If you leave '
                      'this recipe, you will have to restart this recipe the '
                      'next time.',
                  labelType: LabelType.message,
                ),
                const SizedBox(height: 24.0),
                const Divider(),
                const SizedBox(height: 16.0),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextButton(
                      style: ThemeConstants.textButton7ThemeData.style,
                      onPressed: () {
                        Navigator.pop(context); // Pop dialog.
                      },
                      child: const Text('Continue recipe'),
                    ),
                    TextButton(
                      style: ThemeConstants.textButton7ErrorThemeData.style,
                      onPressed: () {
                        Navigator.pop(context); // Pop dialog.

                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          // Technically should not happen, unless in development.
                          Navigator.popAndPushNamed(
                            context,
                            RecipeCatalogueScreen.routeName,
                          );
                        }
                      },
                      child: const Text('Stop recipe'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
