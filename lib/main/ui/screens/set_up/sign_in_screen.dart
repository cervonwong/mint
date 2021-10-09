/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

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
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
