import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static const String assetsFileName = 'assets.zip';
  static String dirSeparator = Platform.isWindows ? '\\' : '/';

  static Future<String?> getLocalAssetsPath() async {
    final directory = await getDownloadsDirectory();
    final path = "${directory!.path}${dirSeparator}assets$dirSeparator";
    return path;
  }

  static Future<bool> extractAssets(String zipPath, String destinyPath) async {
    final zipFile = File(zipPath);

    if (!zipFile.existsSync()) {
      debugPrint('Zip file not found in path: $zipPath');
      return false;
    }

    if (!createDirectoryIfNotExists(destinyPath)) return false;

    final destinationDir = Directory(destinyPath);
    final inputStream = InputFileStream(zipPath);
    final archive = ZipDecoder().decodeBuffer(inputStream);

    for (final file in archive) {
      final newPathName = '${destinationDir.path}$dirSeparator${file.name}';

      if (file.isFile) {
        final data = file.content as List<int>;
        final newFile = File(newPathName);

        newFile.createSync(recursive: true);
        newFile.writeAsBytesSync(data);
      } else {
        final newDirectory = Directory(newPathName);
        newDirectory.createSync(recursive: true);
      }
    }

    inputStream.closeSync();
    zipFile.deleteSync();

    return true;
  }

  static bool createDirectoryIfNotExists(String path) {
    final directory = Directory(path);
    try {
      if (!directory.existsSync()) directory.createSync(recursive: true);
      return true;
    } catch (e) {
      debugPrint('Error creating directory: $e');
      return false;
    }
  }
}
