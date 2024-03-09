import 'dart:io';

import 'package:dio/dio.dart';

class DownloaderRepository {
  static Dio dio = Dio();

  static Future<bool> downloadAssets(String downloadUrl, String savePath) async {
    print("Downloading assets from $downloadUrl to $savePath");
    try {
      print('Creating directory: $savePath');
      final Directory saveDir = Directory(savePath);
      if (!saveDir.existsSync()) {
        saveDir.createSync(recursive: true);
      }
      print('Directory created: $saveDir');
      await dio.download(
        downloadUrl,
        savePath,
        onReceiveProgress: (count, total) {
          String progress = ((count / total) * 100).toStringAsFixed(0);
          print("Downloading: $progress%");
        },
      );
    } catch (e) {
      print("Error: $e");
      return false;
    }
    return true;
  }
}
