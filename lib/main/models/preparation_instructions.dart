/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'dart:collection';

import 'package:meta/meta.dart';

@immutable
class PreparationInstructions {
  UnmodifiableListView<PreparationStep> get steps {
    return UnmodifiableListView(_steps);
  }

  final List<PreparationStep> _steps;

  PreparationInstructions({
    required List<PreparationStep> steps,
  }) : _steps = steps.toList();
}

@immutable
class PreparationStep {
  final String instruction;
  final String? imageUrl; // Can be null if instructor don't provide image.

  const PreparationStep({
    required this.instruction,
    this.imageUrl,
  });
}
