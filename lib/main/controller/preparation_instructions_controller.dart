/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/cupertino.dart';

import '../models/preparation_instructions.dart';

class PreparationInstructionsController extends ChangeNotifier {
  PreparationInstructions? instructions; // Null if not initialised.

  bool _hasInitialised = false;

  PreparationInstructionsController();

  // This function is called in injection_container.dart. This function will be
  // called once only.
  Future<void> initialise() async {
    // Make sure this function is not called when this controller already initialised.
    assert(_hasInitialised == false);

    instructions = await _getInstructions();
    _hasInitialised = true;
  }
}

Future<PreparationInstructions> _getInstructions() async {
  // TODO: 10/31/2021 Implement this. This just placeholder for now.
  return PreparationInstructions(
    steps: [
      PreparationStep(instruction: 'Bing bong!', imageUrl: 'PLACEHOLDER'),
      PreparationStep(instruction: 'Ding dong!', imageUrl: 'PLACEHOLDER'),
      PreparationStep(instruction: 'King kong?', imageUrl: 'PLACEHOLDER'),
    ],
  );
}
