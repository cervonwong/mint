/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/theme_constants.dart';
import 'listen_button.dart';

class StepCard extends StatelessWidget {
  final Color borderColor;
  final String instruction;
  final String? imageUrl;

  const StepCard({
    required this.borderColor,
    required this.instruction,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.whitePrimary,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: imageUrl == null
                ? null
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    text: '',
                    children: instruction
                        .split(' ')
                        .map((word) => TextSpan(
                              text: word + ' ',
                              style: double.tryParse(word) == null
                                  ? ThemeConstants.headline6
                                  : ThemeConstants.headline6.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.greenPrimary,
                                    ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12.0),
                ListenButton(
                  id: instruction,
                  text: instruction,
                  labelType: LabelType.instruction,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
