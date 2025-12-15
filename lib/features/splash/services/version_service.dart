// lib/features/splash/services/version_service.dart
class VersionService {
  /// Mock API to simulate version info
  /// Returns a map:
  /// {
  ///   "latestVersion": "2.0.0",
  ///   "mandatory": true/false,
  ///   "message": "A new version is available!",
  ///   "downloadUrl": "https://example.com/app.apk"
  /// }
  static Future<Map<String, dynamic>> getLatestVersion() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network
    return {
      "latestVersion": "1.0.0",
      "mandatory": false,
      "message": "A new version is available! Please update to continue.",
      "downloadUrl": "https://example.com/app.apk"
    };
  }
}
