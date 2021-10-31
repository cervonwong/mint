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
import '../../shared_components/shared_buttons.dart';
import '../../utils/layout_calculator.dart';
import 'recipe_catalogue_screen.dart';
import 'recipe_completion_screen.dart';

class StepDetailScreen extends StatefulWidget {
  static const routeName = 'trainee/steps';

  StepDetailScreen();

  @override
  State<StepDetailScreen> createState() => _StepDetailScreenState();
}

class _StepDetailScreenState extends State<StepDetailScreen>
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
        appBar: StepDetailAppBar(
          scrollController: _scrollController,
          recipeName: recipe.name,
          currentStepNumber: currentStepNumber,
          totalStepCount: steps.length,
          onHomeButtonPressed: () {
            _showExitConfirmationDialog(context);
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
                        );
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButtonWithIcon7(
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
              SizedBox(
                height: LayoutCalculator.bottomButtonBottomMargin(
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepCard extends StatelessWidget {
  final String instruction;
  final String? imageUrl;

  const StepCard({
    required this.instruction,
    this.imageUrl,
  });

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
            child: imageUrl == null
                ? null
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    text: '',
                    children: instruction
                        .split(' ')
                        .map((word) => TextSpan(
                              text: word + ' ',
                              style: double.tryParse(word) == null
                                  ? ThemeConstants.headline6
                                  : ThemeConstants.headline6.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.greenPrimary,
                                    ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12.0),
                ListenButton(
                  id: instruction,
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
                      TextButton7.error(
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
                      TextButton7(
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
