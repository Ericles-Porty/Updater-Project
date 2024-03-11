import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:updater_project/src/controllers/version_controller_inherited.dart';
import 'package:updater_project/src/core/file_manager.dart';

class DownloadManager {
  static Dio dio = Dio();

  static Future<bool> downloadAssets(String downloadUrl, String savePath, BuildContext context) async {
    final controller = VersionControllerInherited.of(context);
    try {
      if (!FileManager.createDirectoryIfNotExists(savePath)) return false;

      final saveFilePath = savePath + FileManager.assetsFileName;

      await dio.download(
        downloadUrl,
        saveFilePath,
        onReceiveProgress: (received, total) {
          controller.setPercentage((received / total * 100).floor());
        },
      );

      return true;
    } catch (e) {
      debugPrint('Error downloading assets: $e');
      return false;
    }
  }
}
