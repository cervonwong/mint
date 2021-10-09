/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ListenIconButton extends StatelessWidget {
  final String text;

  const ListenIconButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(FluentIcons.speaker_2_24_regular),
    );
  }
}
