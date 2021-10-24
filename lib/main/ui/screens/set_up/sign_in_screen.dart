/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:mint/main/ui/components/shared/listen_icon_button.dart';
import 'package:mint/main/ui/components/shared/shared_buttons.dart';
import 'package:mint/main/ui/components/shared/shared_text_form_field.dart';
import 'package:mint/main/ui/constants/color_constants.dart';
import 'package:mint/main/ui/constants/theme_constants.dart';
import 'package:mint/main/ui/screens/set_up/user_type_set_up_screen.dart';
import 'package:mint/main/ui/utils/layout_calculator.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = 'sign_in';
  static const signInTitleHeroTag = 'Sign in Title Hero';

  const SignInScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: LayoutCalculator.wideMargin(context: context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: signInTitleHeroTag,
                    child: Material(
                      type: MaterialType.transparency,
                      child: SelectableText(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: ThemeConstants.headline4,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  SelectableText(
                    'Please pass your device to your instructor '
                    'to help you sign in.',
                    textAlign: TextAlign.center,
                    style: ThemeConstants.subtitle7.copyWith(
                      color: ColorConstants.blackSecondary,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ListenIconButton(
                    text: 'Please pass your device to your instructor '
                        'to help you sign in.',
                  ),
                  SizedBox(height: 48.0),
                  SelectableText(
                    'Email',
                    style: ThemeConstants.subtitle7,
                  ),
                  SizedBox(height: 4.0),
                  SharedTextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                    ),
                  ),
                  SizedBox(height: 24.0),
                  SelectableText(
                    'Password',
                    style: ThemeConstants.subtitle7,
                  ),
                  SizedBox(height: 4.0),
                  SharedTextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                    ),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton7(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        UserTypeSetUpScreen.routeName,
                      );
                    },
                    child: Text(
                      'Continue',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
