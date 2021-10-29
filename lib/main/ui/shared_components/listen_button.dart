/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../constants/color_constants.dart';
import '../constants/theme_constants.dart';

class ListenButton extends StatelessWidget {
  final String text;
  final LabelType labelType;
  late final String label;
  late final FlutterTts flutterTts;

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

    flutterTts = FlutterTts();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(FluentIcons.speaker_2_24_regular),
      label: Text(label),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(ThemeConstants.button7),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        visualDensity: const VisualDensity(vertical: 2.0),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorConstants.blackSecondary;
          }
          return ColorConstants.greenPrimary;
        }),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorConstants.blackTertiary;
          }
          return ColorConstants.greenOverlay;
        }),
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return BorderSide.none;
          }
          return const BorderSide(color: ColorConstants.greenPrimary);
        }),
      ),
      onPressed: () {
        flutterTts.speak(text);
      },
    );
  }
}

enum LabelType {
  name,
  instructions,
  message,
}
