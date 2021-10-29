/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
      case LabelType.instruction:
        label = 'Listen to instruction';
        break;
      case LabelType.message:
        label = 'Listen to message';
        break;
    }

    flutterTts = FlutterTts();
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
        onPressed: () {
          flutterTts.speak(text);
        },
        // TODO: 10/27/2021 When logic implemented, should call a controller
        //  which calls Google's TTS to generate and audio file?? and then play
        //  the audio file?? If want to minimise number of calls to TTS,
        //  can store generated audio clips in Cloud Storage with the `text` as
        //  the id, and check if it is already generated, and fetch that.
      ),
    );
  }
}

enum LabelType {
  name,
  instruction,
  message,
}
