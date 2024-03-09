import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static const String _assetsFileName = 'assets.zip';
  static String dirSeparator = Platform.isWindows ? '\\' : '/';

  static Future<String?> getLocalAssetsPath() async {
    final directory = await getTemporaryDirectory();
    // final directory = await getDownloadsDirectory();

    // final path = "${directory!.path}${dirSeparator}assets";
    final path = "${directory!.path}${dirSeparator}assets$dirSeparator";

    return path;
  }

  // static Future<void> extractAsset(String downloadPath) async {
  //   final downloadPathWithFileName = "$downloadPath$_assetsFileName";

  //   final zipFile = File(downloadPathWithFileName);

  //   if (!zipFile.existsSync()) return;

  //   final destinationDir = Directory(downloadPath);

  //   if (!destinationDir.existsSync()) {
  //     destinationDir.createSync(recursive: true);
  //   }

  //   final inputStream = InputFileStream(downloadPathWithFileName);

  //   final archive = ZipDecoder().decodeBuffer(inputStream);

  //   // Extract the contents of the Zip archive to disk.
  //   for (final file in archive) {
  //     final filename = file.name;
  //     if (file.isFile) {
  //       final data = file.content as List<int>;
  //       final newFile = File('${destinationDir.path}$dirSeparator$filename');
  //       newFile.createSync(recursive: true);
  //       newFile.writeAsBytesSync(data);
  //     } else {
  //       final dir = Directory('${destinationDir.path}$dirSeparator$filename');
  //       dir.createSync(recursive: true);
  //     }
  //   }

  //   inputStream.closeSync();

  //   zipFile.deleteSync();
  // }

  static Future<bool> extractAssets(String zipPath, String destinyPath) async {
    final zipFile = File(zipPath);

    if (!zipFile.existsSync()) return false;

    final destinationDir = Directory(destinyPath);

    if (!destinationDir.existsSync()) {
      destinationDir.createSync(recursive: true);
    }

    final inputStream = InputFileStream(zipPath);

    final archive = ZipDecoder().decodeBuffer(inputStream);

    // Extract the contents of the Zip archive to disk.
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        final newFile = File('${destinationDir.path}$dirSeparator$filename');
        newFile.createSync(recursive: true);
        newFile.writeAsBytesSync(data);
      } else {
        final newDirectory = Directory('${destinationDir.path}$dirSeparator$filename');
        newDirectory.createSync(recursive: true);
      }
    }

    return true;
  }
}
