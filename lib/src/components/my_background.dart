import 'package:flutter/material.dart';
import 'package:updater_project/src/utils/colors/my_colors_dark.dart';
import 'package:updater_project/src/utils/colors/my_colors_light.dart';

Container myBackgroundLight({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [MyColorsLight.background, MyColorsLight.inversePrimary],
      ),
    ),
    child: child,
  );
}

Container myBackgroundDark({required Widget child}) {
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
