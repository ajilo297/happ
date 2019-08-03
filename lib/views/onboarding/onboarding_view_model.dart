import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view_model.dart';
import 'package:happ/core/models/user_model.dart';
import 'package:happ/views/dashboard/dashboard_view.dart';
import 'package:meta/meta.dart';
import 'package:happ/core/services/preferences_service.dart';

class OnboardingViewModel extends BaseViewModel {
  PreferenceService _preferenceService;
  final GlobalKey<FormState> formKey = GlobalKey();

  OnboardingViewModel({
    @required PreferenceService preferenceService,
  }) : this._preferenceService = preferenceService;

  String validateName(String name) {
    if (name.isEmpty) {
      return 'Enter your name';
    }
    if (!isValidName(name)) return 'Enter a valid name';
    return null;
  }

  void save() {
    log.i('save');
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
  }

  Future saveName(String name) async {
    log.i('saveName: $name');
    busy = true;
    await _preferenceService.setSignedInUser(
      UserModel(name: name),
    );
    busy = false;
  }

  static bool isValidName(String name) {
    RegExp regex = RegExp(r'(^[a-zA-Z ]*$)');
    return regex.hasMatch(name);
  }

  void navigateToDashboard(BuildContext context) {
    log.i('navigateToDashboard');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardView(),
      ),
    );
  }
}
