import 'dart:async';

import 'package:happ/core/base/base_service.dart';
import 'package:happ/core/models/theme_variant.dart';
import 'package:happ/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService extends BaseService {
  static const String _THEME_KEY = 'selectedTheme';
  static const String _USER_KEY = 'signedInUser';

  // ignore: close_sinks
  StreamController<ThemeVariant> _themeDataStream =
      StreamController.broadcast();
  // ignore: close_sinks
  StreamController<UserModel> _userStream = StreamController.broadcast();

  Stream<ThemeVariant> get selectedThemeStream => _themeDataStream.stream;
  Stream<UserModel> get userStream => _userStream.stream;

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

  Future setSignedInUser(UserModel user) async {
    log.i('setSignedInUser: user: ${user.name}');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(_USER_KEY, user.name);
    _userStream.add(user);
  }

  Future<UserModel> getSignedInUser() async {
    log.i('getSignedInUser');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      String name = preferences.getString(_USER_KEY);
      if (name == null || name.isEmpty) return null;
      UserModel user = UserModel(name: name); 
      _userStream.add(user);
      return user;
    } catch (error) {
      log.w('getSignedInUser: error: ${error.toString()}');
      return null;
    }
  }
}
