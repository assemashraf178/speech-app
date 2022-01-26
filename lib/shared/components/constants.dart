import 'package:flutter/material.dart';
import 'package:speach_app/modules/speech/speach_screen.dart';
import 'package:speach_app/modules/tts/tts_screen.dart';

enum Languages {
  ar,
  en,
}

List<Widget> screens = [
  const SpeechScreen(title: 'Speech'),
  const TTSScreen(),
];
