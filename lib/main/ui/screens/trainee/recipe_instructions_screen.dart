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

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    oldCardRotationAngle = Tween<double>(begin: 0.0, end: 0.07).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.3,
          curve: Curves.easeInOut,
        ),
      ),
    );
    newCardRotationAngle = Tween<double>(begin: 0.07, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.7,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
    animationController.forward();
  }

  Animation<Offset> _generateOldCardTranslationOffset(BuildContext context) {
    return Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: Offset(-1.5 * MediaQuery.of(context).size.width, 0.0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeInBack,
        ),
      ),
    );
  }

  Animation<Offset> _generateNewCardTranslationOffset(BuildContext context) {
    return Tween<Offset>(
      begin: Offset(1.5 * MediaQuery.of(context).size.width, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeOutBack,
        ),
      ),
    );
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
                              offset: _generateNewCardTranslationOffset(context)
                                  .value,
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
                                      offset: _generateOldCardTranslationOffset(
                                              context)
                                          .value,
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
        constraints: const BoxConstraints(maxWidth: 600.0),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: IntrinsicWidth(
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: ThemeConstants.dividerGreenThemeData,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableText(
                    'Back to Home Screen?',
                    textAlign: TextAlign.center,
                    style: ThemeConstants.headline5,
                  ),
                  const SizedBox(height: 8.0),
                  SelectableText(
                    'If you leave this recipe, you will have to restart '
                    'this recipe the next time.',
                    textAlign: TextAlign.center,
                    style: ThemeConstants.body7.copyWith(
                      color: ColorConstants.blackSecondary,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ListenButton(
                    id: 'Instruction',
                    text:
                        'Do you want to go back to the home screen? If you leave '
                        'this recipe, you will have to restart this recipe the '
                        'next time.',
                    labelType: LabelType.message,
                  ),
                  const SizedBox(height: 32.0),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
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
                      TextButton(
                        style: ThemeConstants.textButton7ThemeData.style,
                        onPressed: () {
                          Navigator.pop(context); // Pop dialog.
                        },
                        child: const Text('Continue recipe'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
