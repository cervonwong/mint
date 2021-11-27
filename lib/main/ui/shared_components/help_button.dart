/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';

import '../../services/tts_service.dart';
import '../constants/color_constants.dart';

class HelpButton extends StatelessWidget {
  final String id;
  final String text;

  const HelpButton({
    Key? key,
    required this.id,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedCrossFade(
        duration: const Duration(milliseconds: 200),
        crossFadeState:
            Provider.of<TtsService>(context).currentlyPlayingId == id
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
        firstChild: const Icon(
          FluentIcons.question_circle_24_regular,
          color: ColorConstants.greenPrimary,
        ),
        secondChild: const Center(
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
      ),
      onPressed: () {
        Provider.of<TtsService>(context, listen: false)
            .speak(id: id, text: text);
      },
    );
  }
}
