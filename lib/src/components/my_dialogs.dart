import 'package:flutter/material.dart';
import 'package:updater_project/src/components/my_snack_bars.dart';
import 'package:updater_project/src/controllers/version_controller_inherited.dart';
import 'package:updater_project/src/core/updater.dart';
import 'package:updater_project/src/repositories/release_remote_repository.dart';
import 'package:updater_project/src/utils/colors/my_colors_dark.dart';

Future<void> showSelectVersionDialog(BuildContext context) async {
  final controller = VersionControllerInherited.of(context);
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
                                        ? MyColorsDark.primaryContainer
                                        : MyColorsDark.background),
                                  ),
                                  onPressed: () async {
                                    await _handleVersionSelection(context, version);
                                  },
                                  child: Text(version, style: const TextStyle(color: Colors.white)),
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
  VersionControllerInherited controller = VersionControllerInherited.of(context);

  if (version == controller.getVersion()) {
    Navigator.of(context).pop();
    return;
  }

  downloadingShowDialog(context);

  final bool hasUpdated = await Updater.updateVersion(version);

  if (context.mounted) {
    Navigator.of(context).pop();

    if (hasUpdated) {
      successSnackBar(context, 'Updated to version $version successfully');
      controller.setVersion(version);
    } else {
      errorSnackBar(context, 'Error updating to version $version!');
    }
    Navigator.of(context).pop();
  }
}

downloadingShowDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Downloading version...'),
        ],
      ),
    ),
  );
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
