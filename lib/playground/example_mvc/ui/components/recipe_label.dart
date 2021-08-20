/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';// Remember to import this :) Idk why it isnt automatically imported.

// To generate the template for a stateless widget, type "stless" and it will autogenerate a template.
class RecipeLabel extends StatelessWidget {
  const RecipeLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Delicious steak with a side of greens',
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
