import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static Future<String> version() async {
    final info = await PackageInfo.fromPlatform();
    return 'v${info.version} (${info.buildNumber})';
  }
}
