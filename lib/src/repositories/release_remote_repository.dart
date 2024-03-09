import 'package:dio/dio.dart';
import 'package:updater_project/src/models/github_latest_release_model.dart';

class ReleaseRemoteRepository {
  static Dio dio = Dio();

  static const String endpointLatestVersion = 'https://api.github.com/repos/ericles-porty/Updater-Project/releases/latest';
  static const String endpointVersions = 'https://api.github.com/repos/ericles-porty/Updater-Project/releases';

  static Future<List<String>> getAllReleaseVersions() async {
    Response response = await dio.get(endpointVersions);

    List<String> versions = [];

    for (var release in response.data) {
      versions.add(release['tag_name']);
    }

    return versions;
  }

  static Future<String> getLatestReleaseVersion() async {
    Response response = await dio.get(endpointLatestVersion);

    final latestRelease = GithubBody.fromJson(response.data);

    return latestRelease.tagName;
  }

  static Future<String> getDownloadUrlByVersion(String version) async {
    Response response = await dio.get(endpointVersions);

    String downloadUrl = '';

    final releases = response.data.map((release) => GithubBody.fromJson(release)).toList();

    final releaseChoosen = releases.firstWhere((release) => release.tagName == version);

    downloadUrl = releaseChoosen.assets.first.browserDownloadUrl;

    return downloadUrl;
  }

  static Future<String> getDownloadUrlFromLatestVersion() async {
    final response = await dio.get(endpointLatestVersion);

    final latestRelease = GithubBody.fromJson(response.data);

    return latestRelease.assets.first.browserDownloadUrl;
  }
}
