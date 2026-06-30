import 'package:desk_wellness/core/utils/platform_native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService() {
    if (isMobileNative) {
      // Warm up native channel after first frame (avoids hot-restart noise).
      Future.microtask(init);
    } else {
      _available = false;
    }
  }

  final _tts = FlutterTts();
  bool _ready = false;
  bool _available = true;
  bool _loggedUnavailable = false;

  bool get isAvailable => _available && isMobileNative;

  Future<bool> init() async {
    if (!isMobileNative) {
      _available = false;
      return false;
    }
    if (_ready) return _available;
    try {
      await _tts.awaitSpeakCompletion(true);
      await _tts.setLanguage('en-US');
      await _tts.setSpeechRate(0.45);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
      _ready = true;
      _available = true;
      return true;
    } on MissingPluginException {
      _markUnavailable();
      return false;
    } on PlatformException {
      _markUnavailable();
      return false;
    }
  }

  void _markUnavailable() {
    _available = false;
    if (!_loggedUnavailable) {
      _loggedUnavailable = true;
      debugPrint('TTS: native plugin not ready. $kNativePluginHint');
    }
  }

  Future<bool> speak(String text) async {
    if (!isMobileNative) return false;
    if (!await init()) return false;
    try {
      await _tts.stop();
      final result = await _tts.speak(text);
      return result == 1;
    } on MissingPluginException {
      _markUnavailable();
      return false;
    } on PlatformException catch (e) {
      debugPrint('TTS speak failed: $e');
      return false;
    }
  }

  Future<void> stop() async {
    if (!_available || !_ready) return;
    try {
      await _tts.stop();
    } on PlatformException catch (e) {
      debugPrint('TTS stop failed: $e');
    }
  }
}
