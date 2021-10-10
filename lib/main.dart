/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:mint/main/ui/controllers/text_theme_controller.dart';
import 'package:mint/main/ui/screens/set_up/sign_in_screen.dart';
import 'package:mint/main/ui/screens/set_up/user_type_set_up_screen.dart';
import 'main/di/injection_container.dart' as injection_container;
import 'main/ui/controllers/layout_controller.dart';
import 'main/ui/controllers/theme_controller.dart';

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
      theme: null, // Useless, will define in a `Theme` wrapper below.
      initialRoute: SignInScreen.routeName,
      routes: {
        SignInScreen.routeName: (context) => BootloaderWrapper(
              screen: SignInScreen(),
            ),
        UserTypeSetUpScreen.routeName: (context) => BootloaderWrapper(
              screen: UserTypeSetUpScreen(),
            ),
      },
    );
  }
}

class BootloaderWrapper extends StatelessWidget {
  final Widget screen;

  final layoutController = GetIt.instance<LayoutController>();
  final textThemeController = GetIt.instance<TextThemeController>();
  final themeController = GetIt.instance<ThemeController>();

  BootloaderWrapper({required this.screen});

  @override
  Widget build(BuildContext context) {
    layoutController.updateScreenWidth(MediaQuery.of(context).size.width);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => layoutController),
        ChangeNotifierProvider(create: (_) => textThemeController),
        ChangeNotifierProvider(create: (_) => themeController),
      ],
      child: Theme(
        data: themeController.themeData,
        child: screen,
      ),
    );
  }
}
