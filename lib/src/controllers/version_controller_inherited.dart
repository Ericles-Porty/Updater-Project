import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VersionControllerInherited extends InheritedNotifier<ValueNotifier<String>> {
  int percentage = 0;
  VersionControllerInherited({
    required String version,
    super.key,
    required super.child,
  }) : super(
          notifier: ValueNotifier(version),
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

  void setPercentage(int percentage) {
    this.percentage = percentage;
    notifier!.value = percentage.toStringAsFixed(0);
  }

  int getPercentage() => percentage;

  @override
  bool updateShouldNotify(VersionControllerInherited oldWidget) {
    return oldWidget.notifier!.value != notifier!.value || oldWidget.percentage != percentage;
  }
}
