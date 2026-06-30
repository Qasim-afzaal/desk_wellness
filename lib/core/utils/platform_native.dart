import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

/// True when running a native iOS or Android build (not web/desktop).
bool get isMobileNative {
  if (kIsWeb) return false;
  return Platform.isIOS || Platform.isAndroid;
}

/// Hot restart does not register new native plugins — full rebuild required.
const kNativePluginHint =
    'Stop the app completely, then run: flutter run (hot restart is not enough)';
