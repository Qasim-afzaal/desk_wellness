import 'package:desk_wellness/core/utils/platform_native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

class WidgetService {
  static const androidProvider = 'AffirmlyWidgetProvider';
  static const iosName = 'AffirmlyWidget';
  static const appGroupId = 'group.com.intellig.deskwellness.affirmly';

  bool _initialized = false;
  bool _available = false;
  bool _loggedUnavailable = false;

  bool get isSupported => _available;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    if (!isMobileNative) {
      _available = false;
      return;
    }

    try {
      await HomeWidget.setAppGroupId(appGroupId);
      _available = true;
    } on MissingPluginException {
      _markUnavailable();
    } on PlatformException {
      _markUnavailable();
    }
  }

  void _markUnavailable() {
    _available = false;
    if (!_loggedUnavailable) {
      _loggedUnavailable = true;
      debugPrint('Home widget: native plugin not ready. $kNativePluginHint');
    }
  }

  Future<void> updateAffirmation({
    required String text,
    required String templateId,
    String? backgroundHex,
    String? textColorHex,
    String? accentHex,
    bool? showBrand,
  }) async {
    if (!isMobileNative) return;
    await init();
    if (!_available) return;

    try {
      await HomeWidget.saveWidgetData<String>('affirmation_text', text);
      await HomeWidget.saveWidgetData<String>('template_id', templateId);
      if (backgroundHex != null) {
        await HomeWidget.saveWidgetData<String>('background_hex', backgroundHex);
      }
      if (textColorHex != null) {
        await HomeWidget.saveWidgetData<String>('text_color_hex', textColorHex);
      }
      if (accentHex != null) {
        await HomeWidget.saveWidgetData<String>('accent_hex', accentHex);
      }
      if (showBrand != null) {
        await HomeWidget.saveWidgetData<bool>('show_brand', showBrand);
      }
      await HomeWidget.updateWidget(
        androidName: androidProvider,
        iOSName: iosName,
      );
    } on MissingPluginException {
      _markUnavailable();
    } on PlatformException catch (e) {
      debugPrint('Widget update failed: $e');
    }
  }

  Future<bool> requestPinWidget() async {
    if (!isMobileNative) return false;
    await init();
    if (!_available) return false;

    try {
      await HomeWidget.requestPinWidget(
        androidName: androidProvider,
        qualifiedAndroidName: 'com.intellig.deskwellness.desk_wellness.$androidProvider',
      );
      return true;
    } on MissingPluginException {
      _markUnavailable();
      return false;
    } on PlatformException catch (e) {
      debugPrint('Pin widget failed: $e');
      return false;
    }
  }

  static String colorToHex(int argb) {
    final rgb = argb & 0xFFFFFF;
    return '#${rgb.toRadixString(16).padLeft(6, '0')}';
  }
}
