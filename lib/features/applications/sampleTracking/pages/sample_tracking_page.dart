// lib/features/dashboard/pages/sample_tracking_page.dart
import 'package:flutter/material.dart';
import 'package:styx/features/applications/sampleTracking/widgets/sample_drawer.dart';

class SampleTrackingPage extends StatelessWidget {
  const SampleTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample Tracking')),
      drawer: const SampleTrackingDrawer(),
      body: const Center(
        child: Text('Sample Tracking Module'),
      ),
    );
  }
}
