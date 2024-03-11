import 'package:flutter/material.dart';
import 'package:updater_project/src/components/my_credits_icon_button.dart';
import 'package:updater_project/src/controllers/version_controller.dart';

AppBar myAppBar(context) {
  final VersionController versionController = VersionController.of(context);
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: myCreditsIconButton(),
      ),
    ],
    title: Text('Updater Project ${versionController.getVersion()}'),
  );
}
