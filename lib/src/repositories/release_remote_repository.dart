import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:updater_project/src/models/github_latest_release_model.dart';

class ReleaseRemoteRepository {
  static Dio dio = Dio();

  static const String endpointLatestVersion = 'https://api.github.com/repos/ericles-porty/Updater-Project/releases/latest';
  static const String endpointVersions = 'https://api.github.com/repos/ericles-porty/Updater-Project/releases';

  static Future<List<String>> getAllReleaseVersions() async {
    Response response = await dio.get(endpointVersions);

    final releases = response.data.map((release) => GithubBody.fromJson(release)).toList();
    final List<String> releaseVersions = [];

    for (var release in releases) {
      releaseVersions.add(release.tagName);
    }

    return releaseVersions;
  }

  static Future<String> getLatestReleaseVersion() async {
    Response response = await dio.get(endpointLatestVersion);
    final latestRelease = GithubBody.fromJson(response.data);
    return latestRelease.tagName;
  }

  static Future<String> getDownloadUrlByVersion(String version) async {
    try {
      Response response = await dio.get(endpointVersions);

      final releases = response.data.map((release) => GithubBody.fromJson(release)).toList();
      final releaseChoosen = releases.firstWhere((release) => release.tagName == version);
      final downloadUrl = releaseChoosen.assets.first.browserDownloadUrl;

      return downloadUrl;
    } catch (e) {
      debugPrint('Error getting download url: $e');
      return '';
    }
  }

  static Future<String> getDownloadUrlFromLatestVersion() async {
    try {
      final response = await dio.get(endpointLatestVersion);
      final latestRelease = GithubBody.fromJson(response.data);
      return latestRelease.assets.first.browserDownloadUrl;
    } catch (e) {
      debugPrint('Error getting download url: $e');
      return '';
    }
  }
}
