import 'package:flutter/widgets.dart';
import 'package:happ/core/base/base_view_model.dart';
import 'package:happ/core/models/theme_variant.dart';
import 'package:happ/core/services/preferences_service.dart';

class DashboardViewModel extends BaseViewModel {
  bool _value = false;
  PreferenceService _preferenceService;

  DashboardViewModel({
    @required PreferenceService preferenceService,
  }) : this._preferenceService = preferenceService {
    _preferenceService.selectedTheme.then((variant) {
      log.i(
        'constructor: '
        'variant: ${variant.variant.toString().split('.').last}',
      );
      switch (variant.variant) {
        case Variant.dark:
          this.value = true;
          break;
        case Variant.light:
          this.value = false;
          break;
      }
    });
  }

  bool get value => this._value;
  set value(bool value) {
    this._value = value;
    _preferenceService.setTheme(
      value ? ThemeVariant.fromIndex(1) : ThemeVariant.fromIndex(2),
    );
    notifyListeners();
  }

  void onChanged(bool value) {
    log.i('onChanged: value: $value');
    this.value = value;
  }
}
