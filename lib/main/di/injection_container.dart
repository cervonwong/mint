/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:get_it/get_it.dart';

import 'package:mint/main/ui/utils/layout_controller.dart';

void configureDependencies() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton(() => LayoutController());
}
