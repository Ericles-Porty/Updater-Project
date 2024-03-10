import 'package:flutter/material.dart';

class VersionControllerInherited extends InheritedNotifier<ValueNotifier<String>> {
  VersionControllerInherited({
    required String version,
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          notifier: ValueNotifier(version),
          child: child,
        );

  static VersionControllerInherited of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<VersionControllerInherited>();
    if (result == null) {
      throw FlutterError(
          'VersionControllerInherited.of() called with a context that does not contain a VersionControllerInherited.');
    }
    return result;
  }

  static VersionControllerInherited? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VersionControllerInherited>();
  }

  void setVersion(String version) {
    notifier!.value = version;
  }

  String getVersion() => notifier!.value;

  @override
  bool updateShouldNotify(VersionControllerInherited oldWidget) {
    return oldWidget.notifier!.value != notifier!.value;
  }
}
