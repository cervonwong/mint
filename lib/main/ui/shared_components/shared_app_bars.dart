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

  const TitleRevealAppBar({required this.scrollController});

  @override
  State<TitleRevealAppBar> createState() => _TitleRevealAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _TitleRevealAppBarState extends State<TitleRevealAppBar> {
  bool isElevated = false;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      var criteria = widget.scrollController.offset > 100;
      if (criteria != isElevated) {
        setState(() {
          isElevated = criteria;
        });
      }
    });
    super.initState();
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
            horizontal: LayoutCalculator.margin(context: context) -
                8.0, // 8.0 is margin around IconButton.
          ),
          child: SizedBox(
            height: 56.0,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    FluentIcons.navigation_24_regular,
                    color: ColorConstants.blackPrimary,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                const SizedBox(width: 32.0),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isElevated ? 1.0 : 0.0,
                  child: SelectableText(
                    'My Recipes',
                    style: ThemeConstants.headline6,
                  ),
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

class StepDetailAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController scrollController;
  final VoidCallback onHomeButtonPressed;

  const StepDetailAppBar({
    required this.scrollController,
    required this.onHomeButtonPressed,
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
    widget.scrollController.addListener(() {
      var criteria = widget.scrollController.offset != 0.0;
      if (criteria != isElevated) {
        setState(() {
          isElevated = criteria;
        });
      }
    });
    super.initState();
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
            horizontal: LayoutCalculator.wideMargin(context: context) -
                8.0, // 8.0 is margin around IconButton.
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
                      const SizedBox(height: 8.0),
                      SelectableText(
                        'Step 3 of 5',
                        style: ThemeConstants.headline6,
                      ),
                      SelectableText(
                        'You are making Fried Chicken Wings for Nasi Lemak.',
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
      ),
    );
  }
}
