// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:updater_project/src/controllers/version_controller_inherited.dart';
import 'package:updater_project/src/core/updater.dart';
import 'package:updater_project/src/repositories/release_remote_repository.dart';

class HomePageInherited extends StatefulWidget {
  const HomePageInherited({super.key});

  @override
  State<HomePageInherited> createState() => _HomePageInheritedState();
}

class _HomePageInheritedState extends State<HomePageInherited> {
  bool isDownloading = false;

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
              !isDownloading
                  ? ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () async {
                        await _checkForUpdates();
                      },
                      child: const Text('Check for updates'),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              ElevatedButton(
                onPressed: () async {
                  await _showVersionDialog(context);
                },
                child: const Text('Select Version'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _checkForUpdates() async {
    setState(() {
      isDownloading = true;
    });
    await Updater.checkForUpdates();
    setState(() {
      isDownloading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Update checked'),
        backgroundColor: Colors.green,
      ),
    );
    final hasUpdate = await Updater.checkForUpdates();
    if (!hasUpdate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No updates available'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _showVersionDialog(BuildContext context) async {
    final controller = VersionControllerInherited.of(context);
    final releaseVersions = await ReleaseRemoteRepository.getAllReleaseVersions();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  child: const Center(child: Text('Select a version to set as local release version:')),
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
                                    backgroundColor: MaterialStateProperty.all(
                                        controller.getVersion() == version ? Colors.green : Colors.blue),
                                  ),
                                  onPressed: () async {
                                    await _handleVersionSelection(controller, version);
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleVersionSelection(VersionControllerInherited controller, String version) async {
    controller.setVersion(version);
    if (!await Updater.updateVersion(version)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating to version $version!'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Updated to version $version successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
