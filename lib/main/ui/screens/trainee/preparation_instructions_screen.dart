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
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, _) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.translate(
                            offset: _generateNewCardTranslationOffset(context)
                                .value,
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
                                    offset: _generateOldCardTranslationOffset(
                                            context)
                                        .value,
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
                      );
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
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
