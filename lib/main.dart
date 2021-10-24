/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:mint/main/ui/constants/theme_constants.dart';
import 'package:mint/main/ui/screens/set_up/sign_in_screen.dart';
import 'package:mint/main/ui/screens/set_up/user_type_set_up_screen.dart';
import 'main/di/injection_container.dart' as injection_container;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  injection_container.configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mint 🌿',
      theme: ThemeConstants.themeData,
      initialRoute: SignInScreen.routeName,
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
        UserTypeSetUpScreen.routeName: (context) => UserTypeSetUpScreen(),
      },
    );
  }
}
