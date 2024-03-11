import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:updater_project/src/controllers/download_progress_controller.dart';
import 'package:updater_project/src/core/file_manager.dart';

class DownloadManager {
  static Dio dio = Dio();

  static Future<bool> downloadAssets(String downloadUrl, String savePath, BuildContext context) async {
    final controller = DownloadProgressController.of(context);
    try {
      if (!FileManager.createDirectoryIfNotExists(savePath)) return false;

      final saveFilePath = savePath + FileManager.assetsFileName;

      await dio.download(
        downloadUrl,
        saveFilePath,
        onReceiveProgress: (received, total) {
          controller.setProgress((received / total * 100).toInt());
        },
      );

      return true;
    } catch (e) {
      debugPrint('Error downloading assets: $e');
      return false;
    }
  }
}
