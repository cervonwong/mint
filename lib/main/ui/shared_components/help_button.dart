/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../constants/color_constants.dart';

class HelpButton extends StatelessWidget {
  const HelpButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        FluentIcons.question_circle_24_regular,
        color: ColorConstants.greenPrimary,
      ),
      onPressed: () {},
    );
  }
}
