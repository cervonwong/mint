/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:meta/meta.dart';

@immutable
class RecipeStep {
  final String instruction;
  final String? imageUrl;

  RecipeStep({required this.instruction, this.imageUrl});
}
