/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/random_recipe_controller.dart';
import 'ui/screens/random_recipe_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // This `ChangeNotifierProvider` makes our `RandomRecipeController` accessible
    // to all widgets below it.
    return ChangeNotifierProvider(
      create: (context) => RandomRecipeController(),
      child: MaterialApp(
        home: RandomRecipeScreen(),
      ),
    );
  }
}
