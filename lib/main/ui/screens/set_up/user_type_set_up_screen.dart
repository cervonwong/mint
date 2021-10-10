/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:mint/main/ui/constants/color_constants.dart';
import 'package:mint/main/ui/controllers/layout_controller.dart';
import 'package:mint/main/ui/controllers/text_theme_controller.dart';
import 'package:mint/main/ui/screens/set_up/sign_in_screen.dart';

class UserTypeSetUpScreen extends StatelessWidget {
  static const routeName = 'user_type_set_up';

  const UserTypeSetUpScreen();

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
                    tag: SignInScreen.signInTitleHeroTag,
                    child: Material(
                      type: MaterialType.transparency,
                      child: SelectableText(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: GetIt.instance<TextThemeController>().headline4,
                      ),
                    ),
                  ),
                  SizedBox(height: 48.0),
                  UserTypeOptionCard(
                    label: 'Sign in for a trainee',
                    iconData: FluentIcons.person_48_filled,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 32.0),
                  UserTypeOptionCard(
                    label: 'Sign in as an instructor',
                    iconData: FluentIcons.chart_person_48_filled,
                    onTap: () {},
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

class UserTypeOptionCard extends StatelessWidget {
  final String label;
  final IconData iconData;
  final GestureTapCallback onTap;

  const UserTypeOptionCard({
    required this.label,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36.0),
      ),
      elevation: 0.0,
      color: ColorConstants.greenOverlay,
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(36.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 36.0,
          ),
          child: Row(
            children: [
              Expanded(
                // Not SelectableText to make entire card clickable.
                child: Text(
                  label,
                  style: Provider.of<TextThemeController>(context).headline6,
                ),
              ),
              Icon(
                iconData,
                size: 96.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
