/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../../constants/theme_constants.dart';
import '../../shared_components/listen_button.dart';
import '../../shared_components/shared_app_bars.dart';
import '../../utils/layout_calculator.dart';
import 'recipe_catalogue_screen.dart';

class NameSelectionScreen extends StatelessWidget {
  static const routeName = 'trainee';
  late final List<String> names;

  NameSelectionScreen() {
    names = [
      'Andrea Lim',
      'Barry Tan',
      'Chantal Wong',
      'Dorian Lee',
      'Erin Teo',
      'Fernand Ong',
      'Germaine Chan',
      'Humberto Ng',
      'Imelda Chan',
      'Jerry Yeo',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutCalculator.breakpoint(context: context) ==
            LayoutBreakpoint.smallest
        ? _SmallestNameSelectionScreen(names: names)
        : _SmallAndLargerNameSelectionScreen(names: names);
  }
}

class _SmallestNameSelectionScreen extends StatefulWidget {
  final List<String> names;

  _SmallestNameSelectionScreen({required this.names});

  @override
  State<_SmallestNameSelectionScreen> createState() =>
      _SmallestNameSelectionScreenState();
}

class _SmallestNameSelectionScreenState
    extends State<_SmallestNameSelectionScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TitleRevealAppBar(
        scrollController: _scrollController,
        hasDrawer: false,
        title: 'Please press your name',
        actions: [
          _PressNameInstructionListenButton(),
        ],
        actionsPersistent: false,
        revealOffset: 180.0,
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutCalculator.margin(context: context),
            ),
            child: SelectableText(
              'Please press your name',
              textAlign: TextAlign.center,
              style: ThemeConstants.headline4,
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutCalculator.margin(context: context),
            ),
            child: SelectableText(
              'Swipe up if you do not see your name.',
              textAlign: TextAlign.center,
              style: ThemeConstants.subtitle7.copyWith(
                color: ColorConstants.blackSecondary,
              ),
            ),
          ),
          const SizedBox(height: 32.0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutCalculator.margin(context: context),
            ),
            child: _PressNameInstructionListenButton(),
          ),
          const SizedBox(height: 48.0),
          for (final name in widget.names)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: LayoutCalculator.margin(context: context),
              ),
              child: _NameCard(name: name),
            ),
        ],
      ),
    );
  }
}

class _SmallAndLargerNameSelectionScreen extends StatelessWidget {
  final List<String> names;

  _SmallAndLargerNameSelectionScreen({required this.names});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: LayoutCalculator.margin(context: context),
                        ),
                        child: SelectableText(
                          'Please press your name',
                          style: ThemeConstants.headline4,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Padding(
                        padding: EdgeInsets.only(
                          left: LayoutCalculator.margin(context: context),
                        ),
                        child: SelectableText(
                          'Swipe up if you do not see your name.',
                          style: ThemeConstants.subtitle7.copyWith(
                            color: ColorConstants.blackSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Padding(
                        padding: EdgeInsets.only(
                          left: LayoutCalculator.margin(context: context),
                        ),
                        child: _PressNameInstructionListenButton(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 64.0),
                  for (final name in names)
                    Padding(
                      padding: EdgeInsets.only(
                        right: LayoutCalculator.margin(context: context),
                        left: 32.0,
                      ),
                      child: _NameCard(name: name),
                    ),
                  const SizedBox(height: 64.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NameCard extends StatelessWidget {
  final String name;

  _NameCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RecipeCatalogueScreen.routeName,
                  (route) => false,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 17.0,
            ),
            child: Center(
              child: Text(
                name,
                style: ThemeConstants.body7,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _PressNameInstructionListenButton extends StatelessWidget {
  _PressNameInstructionListenButton();

  @override
  Widget build(BuildContext context) {
    return ListenButton(
      id: 'Instruction',
      text: 'Please press your name. '
          'Swipe up if you do not see your name',
      labelType: LabelType.instruction,
    );
  }
}
