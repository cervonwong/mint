/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  final RouteSettings routeSettings;

  PageNotFoundScreen({required this.routeSettings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
