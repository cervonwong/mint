/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:get_it/get_it.dart';
import '../controller/current_recipe_controller.dart';
import '../controller/recipe_catalogue_controller.dart';

void configureDependencies() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton(() => RecipeCatalogueController());
  getIt.registerLazySingleton(() => CurrentRecipeController());
}
