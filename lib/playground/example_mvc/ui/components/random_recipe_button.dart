/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart'; // Remember to import this :) Idk why it isnt automatically imported.

// To generate the template for a stateless widget, type "stless" and it will autogenerate a template.
class RandomRecipeButton extends StatelessWidget {
  const RandomRecipeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {  },
      child: Text('Generate random recipe!'),
    );
  }
}


