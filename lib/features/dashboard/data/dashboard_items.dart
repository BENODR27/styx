// lib/features/dashboard/data/dashboard_items.dart
import 'package:flutter/material.dart';
import 'package:styx/features/applications/inventoryAudit/pages/inventory_audit_page.dart';
import 'package:styx/features/applications/sampleTracking/pages/sample_tracking_page.dart';

class DashboardItem {
  final String title;
  final IconData icon;
  final Widget page;

  DashboardItem({
    required this.title,
    required this.icon,
    required this.page,
  });
}

final List<DashboardItem> dashboardItems = [
  DashboardItem(
    title: 'Inventory Audit',
    icon: Icons.fact_check_outlined,
    page: const InventoryAuditPage(),
  ),
  DashboardItem(
    title: 'Sample Tracking',
    icon: Icons.event_available_outlined,
    page: const SampleTrackingPage(),
  ),
];
