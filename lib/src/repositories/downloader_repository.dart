import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:updater_project/src/core/file_manager.dart';

class DownloaderRepository {
  static Dio dio = Dio();

  static Future<bool> downloadAssets(String downloadUrl, String savePath) async {
    try {
      if (!FileManager.createDirectoryIfNotExists(savePath)) return false;

      final saveFilePath = savePath + FileManager.assetsFileName;

      await dio.download(
        downloadUrl,
        saveFilePath,
      );

      return true;
    } catch (e) {
      debugPrint('Error downloading assets: $e');
      return false;
    }
  }
}
