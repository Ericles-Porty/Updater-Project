import 'package:flutter/material.dart';
import 'package:updater_project/src/utils/colors/my_colors_dark.dart';

Container myBackground({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [MyColorsDark.background, MyColorsDark.onInverseSurface],
      ),
    ),
    child: child,
  );
}
