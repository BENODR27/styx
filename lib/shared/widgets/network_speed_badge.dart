import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/network/network_speed_controller.dart';

class NetworkSpeedBadge extends StatelessWidget {
  const NetworkSpeedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final speed = context.watch<NetworkSpeedController>().speedKbps;

    Color color;
    String text;

    if (speed == null) {
      color = Colors.orange;
      text = 'Checking...';
    } else if (speed == 0) {
      color = Colors.red;
      text = '${speed} kbps';
    } else if (speed < 50) {
      color = Colors.green;
      text = 'ok';
    } else {
      color = Colors.tealAccent;
      text = '${speed} kbps';
    }

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.network_check, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
