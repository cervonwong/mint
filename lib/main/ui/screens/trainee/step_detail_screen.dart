/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';
import '../../shared_components/shared_app_bar.dart';

class StepDetailScreen extends StatefulWidget {
  static const routeName = 'steps';

  StepDetailScreen();

  @override
  State<StepDetailScreen> createState() => _StepDetailScreenState();
}

class _StepDetailScreenState extends State<StepDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SharedAppBar(scrollController: _scrollController),
    );
  }
}

