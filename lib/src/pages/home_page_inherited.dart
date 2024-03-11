// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:updater_project/src/components/my_dialogs.dart';
import 'package:updater_project/src/components/my_snack_bars.dart';
import 'package:updater_project/src/controllers/version_controller_inherited.dart';
import 'package:updater_project/src/core/updater.dart';
import 'package:updater_project/src/repositories/release_local_repository.dart';

class HomePageInherited extends StatefulWidget {
  const HomePageInherited({super.key});

  @override
  State<HomePageInherited> createState() => _HomePageInheritedState();
}

class _HomePageInheritedState extends State<HomePageInherited> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 160,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    await _checkForUpdates();
                  },
                  child: const FittedBox(child: Text('Check for updates')),
                ),
              ),
              SizedBox(
                width: 160,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    await showSelectVersionDialog(context);
                  },
                  child: const FittedBox(child: Text('Select Version')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _checkForUpdates() async {
    final bool hasUpdate = await Updater.checkForUpdates();

    if (!hasUpdate) {
      successSnackBar(context, 'No updates available');
      return;
    }

    final userOption = await getUserOptionDialog(context);

    if (!userOption) {
      return;
    }

    downloadingShowDialog(context);

    final hasUpdated = await Updater.updateToLatestVersion(context);

    Navigator.of(context).pop();

    if (hasUpdated) {
      successSnackBar(context, 'Updated to latest version successfully');

      final localReleaseVersion = await ReleaseLocalRepository.getLocalReleaseVersion() ?? '';
      final versionController = VersionControllerInherited.of(context);
      versionController.setVersion(localReleaseVersion);
    } else {
      errorSnackBar(context, 'Error updating to latest version!');
    }
  }
}
