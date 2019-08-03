import 'package:flutter/widgets.dart';
import 'package:happ/core/base/base_view_model.dart';
import 'package:happ/core/models/theme_variant.dart';
import 'package:happ/core/services/preferences_service.dart';
import 'package:intl/intl.dart';

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

  Future runTimer() async {
    if (!this.isDisposed) {
      await Future.delayed(Duration(seconds: 5));
      notifyListeners();
      runTimer();
    }
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

  String get timeOfDay {
    DateTime dateTime = DateTime.now();
    if (dateTime.hour >= 3 && dateTime.hour < 12) {
      return 'morning';
    } else if (dateTime.hour == 12) {
      return 'noon';
    } else if (dateTime.hour > 12 && dateTime.hour < 16) {
      return 'afternoon';
    } else if (dateTime.hour >= 16 && dateTime.hour < 19) {
      return 'evening';
    } else {
      return 'night';
    }
  }

  String get time {
    DateFormat format = DateFormat('hh:mm');
    return format.format(DateTime.now());
  }

  String get amPm {
    return DateTime.now().hour >= 12 ? 'PM' : 'AM';
  }
}
