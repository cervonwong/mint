/*
 * Copyright (C) 2021 Cervon Wong and Lee I-Shiang
 */

import 'package:flutter/foundation.dart';

import 'package:flutter_tts/flutter_tts.dart';

class TtsService extends ChangeNotifier {
  final FlutterTts tts;
  String? currentlyPlayingId;

  TtsService({required this.tts}) {
    tts.setCompletionHandler(() {
      currentlyPlayingId = null;
      notifyListeners();
    });
  }

  void speak({required String id, required String text}) {
    currentlyPlayingId = id;
    notifyListeners();
    tts.speak(text);
  }
}
