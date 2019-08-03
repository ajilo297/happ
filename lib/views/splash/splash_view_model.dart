import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view_model.dart';
import 'package:happ/core/models/theme_variant.dart';
import 'package:happ/core/models/user_model.dart';
import 'package:happ/core/services/preferences_service.dart';
import 'package:happ/views/dashboard/dashboard_view.dart';
import 'package:happ/views/onboarding/onboarding_view.dart';

class SplashViewModel extends BaseViewModel {
  PreferenceService _preferenceService;

  SplashViewModel({
    @required PreferenceService preferenceService,
  }) : this._preferenceService = preferenceService;

  Future loadAfterDelay({
    Duration duration = const Duration(seconds: 2),
  }) async {
    log.i('loadAfterDelay: duration: ${duration.inSeconds}');
    busy = true;
    ThemeVariant variant = await _preferenceService.selectedTheme;
    _preferenceService.setTheme(variant);
    await Future.delayed(duration);
    busy = false;
  }

  Future navigateToNextScreen(BuildContext context) async {
    log.i('navigateToNextScreen');
    busy = true;
    bool userSignedIn = await _isUserSignedIn();
    busy = false;
    if (userSignedIn) {
      _navigateToDashboardView(context);
    } else {
      _navigateToOnboardingView(context);
    }
  }

  void _navigateToOnboardingView(BuildContext context) {
    log.i('navigateToOnboardingView');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingView(),
      ),
    );
  }

  void _navigateToDashboardView(BuildContext context) {
    log.i('navigateToDashboarView');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardView(),
      ),
    );
  }

  Future<bool> _isUserSignedIn() async {
    log.i('isUserSignedIn');
    busy = true;
    UserModel user = await _preferenceService.getSignedInUser();
    busy = false;
    if (user == null || user.name == null || user.name.isEmpty) return false;
    return true;
  }
}
