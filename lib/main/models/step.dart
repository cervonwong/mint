/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:meta/meta.dart';

@immutable
class Step {
  final String step;
  final String? image;

  Step({required this.step, this.image});
}
