/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mint/main/ui/controllers/text_theme_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sign In',
                style: Provider.of<TextThemeController>(context).headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
