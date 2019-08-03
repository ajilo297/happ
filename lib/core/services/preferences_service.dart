import 'dart:async';

import 'package:happ/core/base/base_service.dart';
import 'package:happ/core/models/theme_variant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService extends BaseService {
  static const String _THEME_KEY = 'selectedTheme';

  // ignore: close_sinks
  StreamController<ThemeVariant> _themeDataStream = StreamController.broadcast();

  Stream get selectedThemeStream => _themeDataStream.stream;

  Future<ThemeVariant> get selectedTheme async {
    log.i('selectedTheme');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int themeIndex;
    try {
      themeIndex = preferences.getInt(_THEME_KEY);
    } catch (error) {
      log.w('selectedTheme: error: ${error.toString()}');
      themeIndex = 1;
    }

    return ThemeVariant.fromIndex(themeIndex);
  }

  Future setTheme(ThemeVariant variant) async {
    log.i('setTheme: '
        'variant: ${variant.variant.toString().split('.').last}, '
        'index: ${variant.index}');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(_THEME_KEY, variant.index);
    _themeDataStream.add(variant);
  }
}
