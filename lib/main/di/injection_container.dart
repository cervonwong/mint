/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:get_it/get_it.dart';

import 'package:mint/main/ui/controllers/layout_controller.dart';
import 'package:mint/main/ui/controllers/text_theme_controller.dart';
import 'package:mint/main/ui/controllers/theme_controller.dart';

void configureDependencies() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton(() => LayoutController());
  getIt.registerLazySingleton(
    () => TextThemeController(layoutController: getIt()),
  );
  getIt.registerLazySingleton(
    () => ThemeController(textThemeController: getIt()),
  );
}
