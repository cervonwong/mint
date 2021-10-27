/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:mint/main/ui/components/shared/help_button.dart';
import 'package:mint/main/ui/constants/color_constants.dart';
import 'package:mint/main/ui/constants/theme_constants.dart';
import 'package:mint/main/ui/utils/layout_calculator.dart';

class SharedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController scrollController;

  const SharedAppBar({required this.scrollController});

  @override
  State<SharedAppBar> createState() => _SharedAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class _SharedAppBarState extends State<SharedAppBar> {
  bool isInOverlayMode = false;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      var criteria = widget.scrollController.offset > 100;
      if (criteria != isInOverlayMode) {
        setState(() {
          isInOverlayMode = criteria;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      color: isInOverlayMode
          ? ColorConstants.ivory100
          : ColorConstants.ivoryPrimary,
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
                SizedBox(width: 32.0),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isInOverlayMode ? 1.0 : 0.0,
                  child: SelectableText(
                    'My Recipes',
                    style: ThemeConstants.headline6,
                  ),
                ),
                Spacer(),
                HelpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
