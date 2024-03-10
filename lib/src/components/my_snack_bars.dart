import 'package:flutter/material.dart';
import 'package:updater_project/src/utils/colors/my_colors_dark.dart';

void successSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(color: MyColorsDark.onPrimaryContainer)),
    backgroundColor: MyColorsDark.primaryContainer,
  ));
}

void errorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(color: MyColorsDark.onErrorContainer)),
    backgroundColor: MyColorsDark.errorContainer,
  ));
}
