/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:mint/main/ui/screens/set_up/sign_in_screen.dart';
import 'package:mint/main/ui/themes.dart';
import 'main/di/injection_container.dart' as injection_container;
import 'main/ui/controllers/layout_controller.dart';

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
      title: 'Flutter Demo',
      theme: kThemeData,
      home: LayoutControllerProviderWrapper(),
    );
  }
}

class LayoutControllerProviderWrapper extends StatelessWidget {
  LayoutControllerProviderWrapper({Key? key}) : super(key: key);

  final layoutController = GetIt.instance<LayoutController>();

  @override
  Widget build(BuildContext context) {
    layoutController.updateWidth(MediaQuery.of(context).size.width);

    return ChangeNotifierProvider(
      create: (_) {
        return layoutController;
      },
      child: SignInScreen(),
    );
  }
}
