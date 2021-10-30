/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../constants/theme_constants.dart';

class ListenButton extends StatelessWidget {
  final String id;
  final String text;
  final LabelType labelType;
  late final String label;

  ListenButton({
    required this.id,
    required this.text,
    required this.labelType,
  }) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        outlinedButtonTheme: ThemeConstants.listenButtonThemeData,
      ),
      child: OutlinedButton(
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState:
              Provider.of<TtsService>(context).currentlyPlayingId == id
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
          firstChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.speaker_2_24_regular),
              const SizedBox(width: 8.0),
              Text(label),
            ],
          ),
          secondChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          Provider.of<TtsService>(context, listen: false)
              .speak(id: id, text: text);
        },
      ),
    );
  }
}

enum LabelType {
  name,
  instruction,
  message,
}

class TtsService extends ChangeNotifier {
  final FlutterTts tts;
  String? currentlyPlayingId;

  TtsService({required this.tts}) {
    tts.setCompletionHandler(() {
      currentlyPlayingId = null;
      notifyListeners();
    });
  }

  void speak({required String id, required String text}) {
    currentlyPlayingId = id;
    print(currentlyPlayingId);
    notifyListeners();
    tts.speak(text);
  }
}
