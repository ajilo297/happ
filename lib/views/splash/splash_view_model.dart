import 'package:happ/core/base/base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  Future loadAfterDelay({
    Duration duration = const Duration(seconds: 2),
  }) async {
    log.i('loadAfterDelay: duration: ${duration.inSeconds}');
    busy = true;
    await Future.delayed(duration);
    busy = false;
  }
}
