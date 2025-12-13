import 'dart:async';
import 'package:http/http.dart' as http;

class NetworkSpeedService {
  static Future<int?> measureSpeedKbps() async {
    try {
      final stopwatch = Stopwatch()..start();

      final response = await http
          .get(
        Uri.parse('https://www.cloudflare.com/cdn-cgi/trace'),
      )
          .timeout(const Duration(seconds: 5));

      stopwatch.stop();

      if (response.statusCode != 200) return null;

      final bytes = response.bodyBytes.length;
      final seconds = stopwatch.elapsedMilliseconds / 1000;

      if (seconds == 0) return null;

      final kbps = (bytes / 1024) / seconds;
      return kbps.round();
    } catch (_) {
      return null;
    }
  }
}
