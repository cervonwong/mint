/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:meta/meta.dart';

@immutable
class RecipeStep {
  final String instruction;
  final String? imageUrl;

  const RecipeStep({required this.instruction, this.imageUrl});
}
