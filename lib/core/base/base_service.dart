import 'package:happ/core/base/logger.dart';
import 'package:logger/logger.dart';

class BaseService {
  Logger log;

  BaseService({String title}) {
    this.log = getLogger(title ?? this.runtimeType.toString());
  }
}
