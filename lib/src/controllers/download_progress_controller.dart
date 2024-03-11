import 'package:flutter/material.dart';

class DownloadProgressController extends InheritedNotifier<ValueNotifier<int>> {
  DownloadProgressController({
    required int progress,
    super.key,
    required super.child,
  }) : super(
          notifier: ValueNotifier(progress),
        );

  static DownloadProgressController of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<DownloadProgressController>();
    if (result == null) {
      throw FlutterError(
          'DownloadProgressController.of() called with a context that does not contain a DownloadProgressController.');
    }

    return result;
  }

  static DownloadProgressController? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DownloadProgressController>();

  void setProgress(int progress) {
    notifier!.value = progress;
  }

  int getProgress() => notifier!.value;
}
