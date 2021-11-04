/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../constants/color_constants.dart';
import '../../constants/theme_constants.dart';
import '../../utils/layout_calculator.dart';
import '../trainee/name_selection_screen.dart';

class DemoIntroScreen extends StatefulWidget {
  static const routeName = 'demo';

  const DemoIntroScreen();

  @override
  State<DemoIntroScreen> createState() => _DemoIntroScreenState();
}

class _DemoIntroScreenState extends State<DemoIntroScreen> {
  bool showVideo = false;

  final YoutubePlayerController _youtubePlayerController =
      YoutubePlayerController(
    initialVideoId: '8FsldVUxE7c',
    params: const YoutubePlayerParams(
      color: 'red',
      strictRelatedVideos: true,
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: LayoutCalculator.wideMargin(context: context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24.0),
                  const Image(
                    width: 360.0 * 0.8,
                    height: 240.0 * 0.8,
                    image: AssetImage(
                      'assets/illustrations/Crab_WooHoo.png',
                    ),
                  ),
                  SelectableText(
                    'Welcome to the Mint demo',
                    textAlign: TextAlign.center,
                    style: (LayoutCalculator.breakpoint(context: context) ==
                                LayoutBreakpoint.smallest
                            ? ThemeConstants.headline4
                            : ThemeConstants.headline3)
                        .copyWith(
                      color: ColorConstants.greenPrimary,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  SelectableText(
                    'Mint is a PWA designed for trainees at APSN Café '
                    'for All who face issues memorising the food recipes. '
                    'We built this app to allow trainees to independently '
                    'learn recipes via step-by-step interactive instructions.',
                    textAlign: TextAlign.center,
                    style: ThemeConstants.body7.copyWith(
                      color: ColorConstants.blackSecondary,
                    ),
                  ),
                  const SizedBox(height: 48.0),
                  ElevatedButton(
                    style: ThemeConstants.elevatedButton7CtaThemeData.style,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        NameSelectionScreen.routeName,
                        (route) => false,
                      );
                    },
                    child: const Text('Try out our app!'),
                  ),
                  const SizedBox(height: 8.0),
                  OpenContainer(
                    transitionDuration: const Duration(milliseconds: 1000),
                    closedColor: Colors.transparent,
                    openColor: Colors.black,
                    closedElevation: 0.0,
                    openElevation: 0.0,
                    closedBuilder: (context, closedBuilder) {
                      return TextButton(
                        style: ThemeConstants.textButton7ThemeData.style,
                        onPressed: () {
                          closedBuilder();
                        },
                        child: const Text('Watch our intro video!'),
                      );
                    },
                    openBuilder: (context, openContainer) {
                      return Column(
                        children: [
                          const SizedBox(height: 4.0),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: ThemeConstants
                                      .textButton7WhiteThemeData.style,
                                  onPressed: () {
                                    openContainer();
                                  },
                                  child: const Text(
                                    'Return to demo homepage',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: YoutubePlayerIFrame(
                              controller: _youtubePlayerController,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
