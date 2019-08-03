import 'dart:async';

import 'package:happ/core/base/base_service.dart';
import 'package:happ/core/models/theme_variant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService extends BaseService {
  static const String _THEME_KEY = 'selectedTheme';
  static const String _USER_KEY = 'signedInUser';

  // ignore: close_sinks
  StreamController<ThemeVariant> _themeDataStream =
      StreamController.broadcast();
  // ignore: close_sinks
  StreamController<String> _userStream = StreamController.broadcast();

  Stream<ThemeVariant> get selectedThemeStream => _themeDataStream.stream;
  Stream<String> get userStream => _userStream.stream;

  Future<ThemeVariant> get selectedTheme async {
    log.i('selectedTheme');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int themeIndex;
    try {
      themeIndex = preferences.getInt(_THEME_KEY);
      _themeDataStream.add(ThemeVariant.fromIndex(themeIndex));
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

  Future setSignedInUser(String user) async {
    log.i('setSignedInUser: user: $user');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(_USER_KEY, user);
  }

  Future<String> getSignedInUser() async {
    log.i('getSignedInUser');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      String user = preferences.getString(_USER_KEY);
      _userStream.add(user);
      return user;
    } catch (error) {
      log.w('getSignedInUser: error: ${error.toString()}');
      return null;
    }
  }
}
