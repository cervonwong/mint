/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';
import '../utils/layout_calculator.dart';
import 'demo/demo_intro_screen.dart';

class PageNotFoundScreen extends StatelessWidget {
  final RouteSettings routeSettings;

  PageNotFoundScreen({required this.routeSettings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutCalculator.wideMargin(context: context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        const Image(
                          width: 360.0,
                          height: 240.0,
                          image: AssetImage(
                            'assets/illustrations/Crab_Thinking.png',
                          ),
                        ),
                        SelectableText(
                          'Error 404: Page not found',
                          textAlign: TextAlign.center,
                          style: ThemeConstants.headline4,
                        ),
                        const SizedBox(height: 16.0),
                        SelectableText(
                          'Debug info: $routeSettings',
                          textAlign: TextAlign.center,
                          style: ThemeConstants.body7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ThemeConstants.elevatedButton7ThemeData.style,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  DemoIntroScreen.routeName,
                  (route) => false,
                );
              },
              child: const Text('Return to start of demo'),
            ),
            SizedBox(
              height: LayoutCalculator.bottomButtonBottomMargin(
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
