import 'dart:async';
import 'package:flutter/material.dart';
import 'network_speed_service.dart';

class NetworkSpeedController extends ChangeNotifier {
  int? _speedKbps;
  Timer? _timer;

  int? get speedKbps => _speedKbps;

  void start() {
    _timer ??= Timer.periodic(
      const Duration(seconds: 10),
          (_) async {
        _speedKbps = await NetworkSpeedService.measureSpeedKbps();
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
