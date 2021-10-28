/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:meta/meta.dart';

@immutable
class RecipeCatalogueInfo {
  final String name;

  final String imageUrl;
  // TODO: 10/28/2021 Feel free to change this if using String is not convenient
  //  to access images this way from Firebase Database.

  RecipeCatalogueInfo({
    required this.name,
    required this.imageUrl,
  });
}
