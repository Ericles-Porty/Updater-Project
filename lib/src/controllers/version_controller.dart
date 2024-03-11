import 'package:flutter/material.dart';

class VersionController extends InheritedNotifier<ValueNotifier<String>> {
  VersionController({
    required String version,
    super.key,
    required super.child,
  }) : super(
          notifier: ValueNotifier(version),
        );

  static VersionController of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<VersionController>();
    if (result == null) {
      throw FlutterError('VersionController.of() called with a context that does not contain a VersionController.');
    }
    return result;
  }

  static VersionController? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<VersionController>();

  void setVersion(String version) {
    notifier!.value = version;
  }

  String getVersion() => notifier!.value;
}
