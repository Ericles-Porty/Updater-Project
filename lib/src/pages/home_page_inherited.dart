// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:updater_project/src/controllers/version_controller_inherited.dart';
import 'package:updater_project/src/core/updater.dart';
import 'package:updater_project/src/repositories/release_local_repository.dart';
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
    final controller = VersionControllerInherited.of(context);
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

                        final latestReleaseVersion = await ReleaseRemoteRepository.getLatestReleaseVersion();
                        if (!await Updater.updateToLatestVersion()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error updating to latest version'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        controller.setVersion(latestReleaseVersion);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Updated to latest version successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text('Check for updates'),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              ElevatedButton(
                onPressed: () async {
                  final releaseVersions = await ReleaseRemoteRepository.getAllReleaseVersions();
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height * 0.1,
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
                                              TextButton(
                                                  onPressed: () async {
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

                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(version)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                },
                child: const Text('Get all release versions'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await ReleaseLocalRepository.setLocalReleaseVersion('0.0');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Local release version reset'),
                    ),
                  );
                  controller.setVersion('0.0');
                },
                child: const Text('Reset local release version'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
