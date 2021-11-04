/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';

import '../../../controller/preparation_instructions_controller.dart';
import '../../constants/color_constants.dart';
import '../../constants/theme_constants.dart';
import '../../shared_components/shared_app_bars.dart';
import '../../shared_components/step_card.dart';
import '../../utils/layout_calculator.dart';
import 'recipe_catalogue_screen.dart';

// This screen has a similar structure with `RecipeInstructionsScreen`.
// Some things are carried over in a hard-coded way to push out the feature
// quickly.
class PreparationInstructionsScreen extends StatefulWidget {
  static const routeName = 'trainee/preparation';

  PreparationInstructionsScreen();

  @override
  State<PreparationInstructionsScreen> createState() =>
      _PreparationInstructionsScreenState();
}

class _PreparationInstructionsScreenState
    extends State<PreparationInstructionsScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int currentStepIndex = 0;
  int currentStepNumber = 1;

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

  @override
  Widget build(BuildContext context) {
    final instructions =
        Provider.of<PreparationInstructionsController>(context).instructions;
    if (instructions == null) {
      return const Scaffold(
        backgroundColor: ColorConstants.greenOverlayOnWhite,
      );
    }
    final steps = instructions.steps;

    return Scaffold(
      backgroundColor: ColorConstants.greenOverlayOnWhite,
      appBar: PreparationInstructionsScreenAppBar(
        scrollController: _scrollController,
        currentStepNumber: currentStepNumber,
        totalStepCount: steps.length,
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
                                borderColor: ColorConstants.greenBorder,
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
                                        borderColor: ColorConstants.greenBorder,
                                        instruction: steps[currentStepIndex - 1]
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
                    RecipeCatalogueScreen.routeName,
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
    );
  }
}
