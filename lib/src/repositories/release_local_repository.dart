import 'package:shared_preferences/shared_preferences.dart';

class ReleaseLocalRepository {
  static const String localReleaseVersionKey = 'localReleaseVersion';

  static Future<String?> getLocalReleaseVersion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(localReleaseVersionKey);
  }

  static Future<void> setLocalReleaseVersion(String version) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(localReleaseVersionKey, version);
  }
}
