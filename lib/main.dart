// ignore_for_file: prefer_relative_imports

/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mint/main/controller/preparation_instructions_controller.dart';
import 'package:mint/main/controller/recipe_catalogue_controller.dart';
import 'package:mint/main/ui/constants/theme_constants.dart';
import 'package:mint/main/ui/screens/trainee/name_selection_screen.dart';
import 'package:mint/main/ui/screens/trainee/preparation_screen.dart';
import 'package:mint/main/ui/screens/trainee/recipe_completion_screen.dart';
import 'package:mint/main/ui/screens/trainee/step_detail_screen.dart';
import 'package:provider/provider.dart';

import 'main/controller/current_recipe_controller.dart';
import 'main/di/injection_container.dart' as injection_container;
import 'main/services/TtsService.dart';
import 'main/ui/screens/trainee/recipe_catalogue_screen.dart';

void main() async {
  // Firebase initialisation.
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseAuth.instance.signInAnonymously();
  await Firebase.initializeApp();

  // Dependency injection initialisation.
  injection_container.configureDependencies();
  await GetIt.instance.allReady();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PreparationInstructionsController>(
          create: (_) => GetIt.instance(),
        ),
        ChangeNotifierProvider<RecipeCatalogueController>(
          create: (_) => GetIt.instance(),
        ),
        ChangeNotifierProvider<CurrentRecipeController>(
          create: (_) => GetIt.instance(),
        ),
        ChangeNotifierProvider<TtsService>(
          create: (context) => GetIt.instance(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mint',
        theme: ThemeConstants.themeData,
        initialRoute: NameSelectionScreen.routeName,
        routes: {
          NameSelectionScreen.routeName: (context) => NameSelectionScreen(),
          PreparationScreen.routeName: (context) => PreparationScreen(),
          RecipeCatalogueScreen.routeName: (context) => RecipeCatalogueScreen(),
          StepDetailScreen.routeName: (context) => StepDetailScreen(),
          RecipeCompletionScreen.routeName: (context) =>
              RecipeCompletionScreen(),
        },
      ),
    );
  }
}
