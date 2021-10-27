/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../constants/theme_constants.dart';

class ListenButton extends StatelessWidget {
  final String text;
  final LabelType labelType;
  late final String label;

  ListenButton({required this.text, required this.labelType}) {
    switch (labelType) {
      case LabelType.name:
        label = 'Listen to name';
        break;
      case LabelType.instructions:
        label = 'Listen to instructions';
        break;
      case LabelType.message:
        label = 'Listen to message';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        outlinedButtonTheme: ThemeConstants.listenButtonThemeData,
      ),
      child: OutlinedButton.icon(
        icon: const Icon(FluentIcons.speaker_2_24_regular),
        label: Text(label),
        onPressed: () {},
      ),
    );
  }
}

enum LabelType {
  name,
  instructions,
  message,
}
