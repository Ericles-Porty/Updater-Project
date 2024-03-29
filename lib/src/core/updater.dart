// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:updater_project/src/controllers/download_progress_controller.dart';
import 'package:updater_project/src/core/file_manager.dart';
import 'package:updater_project/src/repositories/download_manager.dart';
import 'package:updater_project/src/repositories/release_local_repository.dart';
import 'package:updater_project/src/repositories/release_remote_repository.dart';

class Updater {
  static const String _assetsFileName = 'assets.zip';

  static Future<bool> checkForUpdates() async {
    final latestReleaseVersion = await ReleaseRemoteRepository.getLatestReleaseVersion();

    String? localReleaseVersion = await ReleaseLocalRepository.getLocalReleaseVersion();

    return latestReleaseVersion != localReleaseVersion;
  }

  static Future<bool> updateVersion(String version, BuildContext context) async {
    print("Requested updateVersion");

    final downloadUrl = await ReleaseRemoteRepository.getDownloadUrlByVersion(version);
    final downloadPath = await FileManager.getLocalAssetsPath();

    print("downloadUrl: $downloadUrl");
    print("downloadPath: $downloadPath");
    if (downloadPath == null) {
      return false;
    }

    try {
      print("Downloading assets from $downloadUrl to $downloadPath");
      if (!await DownloadManager.downloadAssets(downloadUrl, downloadPath, context)) return false;
      final downloadedZipPath = "$downloadPath$_assetsFileName";
      if (!await FileManager.extractAssets(downloadedZipPath, downloadPath)) return false;
    } catch (e) {
      print("Error: $e");
      return false;
    }

    await ReleaseLocalRepository.setLocalReleaseVersion(version);

    DownloadProgressController.of(context).setProgress(0);

    return true;
  }

  static Future<bool> updateToLatestVersion(BuildContext context) async {
    final latestReleaseVersion = await ReleaseRemoteRepository.getLatestReleaseVersion();
    return await updateVersion(latestReleaseVersion, context);
  }
}
