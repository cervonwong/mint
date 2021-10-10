/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mint/main/ui/components/shared/listen_icon_button.dart';
import 'package:mint/main/ui/components/shared/shared_buttons.dart';
import 'package:mint/main/ui/components/shared/shared_text_form_field.dart';
import 'package:mint/main/ui/constants/color_constants.dart';
import 'package:mint/main/ui/controllers/layout_controller.dart';
import 'package:mint/main/ui/controllers/text_theme_controller.dart';
import 'package:mint/main/ui/screens/set_up/user_type_set_up_screen.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = 'sign_in';
  static const signInTitleHeroTag = 'Sign in Title Hero';

  const SignInScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Provider.of<LayoutController>(context).wideMargin,
            ),
            child: SingleChildScrollView(
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
                        style:
                            Provider.of<TextThemeController>(context).headline4,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  SelectableText(
                    'Please pass your device to your instructor '
                    'to help you sign in.',
                    textAlign: TextAlign.center,
                    style: Provider.of<TextThemeController>(context)
                        .subtitle7
                        .copyWith(
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
                    style: Provider.of<TextThemeController>(context).subtitle7,
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
                    style: Provider.of<TextThemeController>(context).subtitle7,
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
