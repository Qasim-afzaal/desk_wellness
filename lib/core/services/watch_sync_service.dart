import 'package:flutter/foundation.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

class WatchSyncService {
  WatchSyncService() : _watch = WatchConnectivity();

  final WatchConnectivity _watch;

  Future<bool> get isSupported async {
    try {
      return await _watch.isSupported;
    } catch (_) {
      return false;
    }
  }

  Future<bool> get isPaired async {
    try {
      return await _watch.isPaired;
    } catch (_) {
      return false;
    }
  }

  Future<bool> get isReachable async {
    try {
      return await _watch.isReachable;
    } catch (_) {
      return false;
    }
  }

  Future<void> syncAffirmation({
    required String text,
    required String backgroundHex,
    int index = 0,
  }) async {
    try {
      if (!await isSupported) return;
      final payload = {
        'type': 'affirmation',
        'affirmation': text,
        'background': backgroundHex,
        'index': index,
        'updatedAt': DateTime.now().toIso8601String(),
      };
      if (await isReachable) {
        await _watch.sendMessage(payload);
      } else {
        await _watch.updateApplicationContext(payload);
      }
    } catch (e) {
      debugPrint('Watch sync skipped: $e');
    }
  }

  Stream<Map<String, dynamic>> get messageStream => _watch.messageStream;
}
