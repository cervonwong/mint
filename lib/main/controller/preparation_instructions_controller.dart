/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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
  final collection = FirebaseFirestore.instance.collection('preparation');
  final querySnapshot = await collection.doc('preparation_instructions').get();

  final preparationInstructions = PreparationInstructions(
    steps: List<PreparationStep>.from(
      querySnapshot.data()!['steps'].map(
            (item) => PreparationStep(
                instruction: item['step'], imageUrl: item['imageUrl']),
          ),
    ),
  );

  return preparationInstructions;
}
