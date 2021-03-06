/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';

import '../controller/current_recipe_controller.dart';
import '../controller/preparation_instructions_controller.dart';
import '../controller/recipe_catalogue_controller.dart';
import '../services/tts_service.dart';

void configureDependencies() {
  final getIt = GetIt.instance;

  getIt.registerSingletonAsync(() async {
    final controller = PreparationInstructionsController();
    await controller.initialise();
    return controller;
  });
  getIt.registerSingletonAsync(() async {
    final controller = RecipeCatalogueController();
    await controller.initialise();
    return controller;
  });
  getIt.registerLazySingleton(() => FlutterTts());
  getIt.registerLazySingleton(() => TtsService(tts: getIt()));
  getIt.registerLazySingleton(() => CurrentRecipeController());
}
