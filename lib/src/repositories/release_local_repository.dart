import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReleaseLocalRepository {
  static const String localReleaseVersionKey = 'localReleaseVersion';

  static Future<String?> getLocalReleaseVersion() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(localReleaseVersionKey);
    } catch (e) {
      debugPrint('Error getting local release version: $e');
      return null;
    }
  }

  static Future<void> setLocalReleaseVersion(String version) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(localReleaseVersionKey, version);
    } catch (e) {
      debugPrint('Error setting local release version: $e');
    }
  }
}
