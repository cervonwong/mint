/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../constants/color_constants.dart';
import '../constants/theme_constants.dart';
import '../utils/layout_calculator.dart';
import 'help_button.dart';

// Tons of code duplication here :) Don't mind me.

class TitleRevealAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController scrollController;
  final bool hasDrawer;
  final String title;
  final List<Widget> actions;
  final bool actionsPersistent;
  final double revealOffset;

  const TitleRevealAppBar({
    required this.scrollController,
    required this.hasDrawer,
    required this.title,
    this.actions = const [],
    this.actionsPersistent = true,
    this.revealOffset = 50.0,
  });

  @override
  State<TitleRevealAppBar> createState() => _TitleRevealAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(300.0);
}

class _TitleRevealAppBarState extends State<TitleRevealAppBar> {
  bool isRevealed = false;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      final revealCriteria =
          widget.scrollController.offset > widget.revealOffset;
      if (revealCriteria != isRevealed) {
        setState(() {
          isRevealed = revealCriteria;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      color: isRevealed
          ? ColorConstants.ivory100
          : ColorConstants.ivory100.withOpacity(0.0),
      child: IntrinsicHeight(
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.symmetric(
              // 8.0 is margin around IconButton.
              horizontal:
                  LayoutCalculator.appBarHorizontalMargin(context: context) -
                      (widget.hasDrawer ? 8.0 : 0.0),
              vertical: LayoutCalculator.appBarVerticalMargin(context: context),
            ),
            child: Row(
              children: [
                widget.hasDrawer
                    ? IconButton(
                        icon: const Icon(
                          FluentIcons.navigation_24_regular,
                          color: ColorConstants.blackPrimary,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      )
                    : Container(),
                widget.hasDrawer ? const SizedBox(width: 32.0) : Container(),
                Expanded(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: isRevealed ? 1.0 : 0.0,
                    child: Text(
                      widget.title,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: ThemeConstants.headline6,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                widget.actionsPersistent
                    ? Row(
                        children: widget.actions,
                      )
                    : AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity: isRevealed ? 1.0 : 0.0,
                        child: Row(
                          children: widget.actions,
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

class StepDetailAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController scrollController;
  final VoidCallback onHomeButtonPressed;
  final String recipeName;
  final int currentStepNumber;
  final int totalStepCount;

  const StepDetailAppBar({
    required this.scrollController,
    required this.onHomeButtonPressed,
    required this.recipeName,
    required this.currentStepNumber,
    required this.totalStepCount,
  });

  @override
  State<StepDetailAppBar> createState() => _StepDetailAppBarState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(300.0); // A random sufficiently large number.
}

class _StepDetailAppBarState extends State<StepDetailAppBar> {
  bool isElevated = false;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      var criteria = widget.scrollController.offset != 0.0;
      if (criteria != isElevated) {
        setState(() {
          isElevated = criteria;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      color: isElevated ? ColorConstants.ivory100 : ColorConstants.ivoryPrimary,
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: EdgeInsets.symmetric(
            // 8.0 is margin around IconButton.
            horizontal:
                LayoutCalculator.appBarHorizontalMargin(context: context) - 8.0,
            vertical: LayoutCalculator.appBarVerticalMargin(context: context),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    FluentIcons.home_24_regular,
                    color: ColorConstants.blackPrimary,
                  ),
                  onPressed: widget.onHomeButtonPressed,
                ),
                const Spacer(),
                Column(
                  children: [
                    SelectableText(
                      'Step ${widget.currentStepNumber} '
                      'of ${widget.totalStepCount}',
                      style: ThemeConstants.headline6,
                    ),
                    SelectableText(
                      'You are making ${widget.recipeName}.',
                      style: ThemeConstants.body9,
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
                const Spacer(),
                const HelpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
