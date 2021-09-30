import 'package:flutter/foundation.dart';

enum APIEnvironment {
  Sandbox,
  Production,
  ProductionIndonesia,
}

extension APIEnvironmentExt on APIEnvironment {
  String get value => describeEnum(this);
}
