import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:updater_project/src/components/my_snack_bars.dart';
import 'package:updater_project/src/controllers/download_progress_controller.dart';
import 'package:updater_project/src/controllers/version_controller.dart';
import 'package:updater_project/src/core/updater.dart';
import 'package:updater_project/src/repositories/release_remote_repository.dart';

Future<void> showSelectVersionDialog(BuildContext context) async {
  final controller = VersionController.of(context);
  final releaseVersions = await ReleaseRemoteRepository.getAllReleaseVersions();

  if (context.mounted) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, size: 30, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        'Select a version to set as local release version:',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var version in releaseVersions)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 80,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(controller.getVersion() == version
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onPrimary),
                                  ),
                                  onPressed: () async {
                                    await _handleVersionSelection(context, version);
                                  },
                                  child: Text(version,
                                      style: TextStyle(
                                          color: controller.getVersion() == version
                                              ? Theme.of(context).colorScheme.onPrimary
                                              : Theme.of(context).colorScheme.primary)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // back button
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _handleVersionSelection(BuildContext context, String version) async {
  final versionController = VersionController.of(context);

  if (version == versionController.getVersion()) {
    Navigator.of(context).pop();
    return;
  }

  downloadingShowDialog(context);

  final bool hasUpdated = await Updater.updateVersion(version, context);

  if (context.mounted) {
    Navigator.of(context).pop();

    if (hasUpdated) {
      successSnackBar(context, 'Updated to version $version successfully');
      versionController.setVersion(version);
    } else {
      errorSnackBar(context, 'Error updating to version $version!');
    }
    Navigator.of(context).pop();
  }
}

downloadingShowDialog(BuildContext context) {
  if (kIsWeb) {
    _webPlatformAlertDialog(context);
    return;
  }

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text('Downloading', style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: Text(
                '${DownloadProgressController.of(context).getProgress()}%',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: CircularProgressIndicator(
                value: DownloadProgressController.of(context).getProgress() / 100,
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                strokeWidth: 10.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<dynamic> _webPlatformAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Feature not available on web'),
          content: const Text(
              'Sorry, but this feature is just available on mobile and desktop platforms. Please try again on a different platform.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      });
}

Future<bool> getUserOptionDialog(BuildContext context) async {
  final option = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Do you want to update to the latest version?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );

  return option ?? false;
}
