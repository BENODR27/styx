// lib/features/sample_tracking/widgets/sample_drawer.dart
import 'package:flutter/material.dart';
import 'package:styx/features/applications/sampleTracking/pages/sample_tracking_report_page.dart';
import 'package:styx/shared/models/drawer_item.dart';

class SampleTrackingDrawer extends StatelessWidget {
  const SampleTrackingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      DrawerItem(
        title: 'Samples',
        icon: Icons.science_outlined,
        onTap: () {},
      ),
      DrawerItem(
        title: 'Tracking',
        icon: Icons.track_changes_outlined,
        onTap: () {},
      ),
      DrawerItem(
        title: 'Reports',
        icon: Icons.bar_chart_outlined,
        onTap: () {
          Navigator.pop(context); // close drawer first

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SampleTrackingReportPage(),
            ),
          );
        },
      ),
      DrawerItem(
        title: 'Back home',
        icon: Icons.arrow_back,
        onTap: () {
          Navigator.pop(context); // close drawer
          Navigator.pop(context); // go back to dashboard
        },
      ),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset(
                'assets/icons/app_icon.png',
                height: 84,
              ),
            ),
          ),
          ...items.map(
                (item) => ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              onTap: item.onTap,
            ),
          ),
        ],
      ),
    );
  }
}
