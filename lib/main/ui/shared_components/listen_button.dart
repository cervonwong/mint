/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';

import '../../services/tts_service.dart';
import '../constants/theme_constants.dart';

class ListenButton extends StatelessWidget {
  final String id;
  final String text;
  final LabelType labelType;
  late final String label;

  ListenButton({
    Key? key,
    required this.id,
    required this.text,
    required this.labelType,
  }) : super(key: key) {
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.speaker_2_24_regular),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  label,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          secondChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: SizedBox(
                  height: 24.0,
                  width: 24.0,
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
          layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  key: bottomChildKey,
                  top: 0,
                  child: bottomChild,
                ),
                Positioned(
                  key: topChildKey,
                  child: topChild,
                ),
              ],
            );
          },
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
