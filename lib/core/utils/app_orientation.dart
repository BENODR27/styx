// lib/core/utils/app_orientation.dart
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppOrientation {
  static void configure(BuildContext context) {
    final media = MediaQuery.of(context);
    final isMobile = media.size.shortestSide < 600;

    if (isMobile) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }
}
