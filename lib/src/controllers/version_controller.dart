import 'package:flutter/foundation.dart';

class VersionController extends ValueNotifier<String> {
  VersionController() : super("");

  void setVersion(String version) {
    value = version;
    notifyListeners();
  }

  String getVersion() => value;
}
