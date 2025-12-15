// lib/features/dashboard/data/dashboard_items.dart
import 'package:flutter/material.dart';

class DashboardItem {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  DashboardItem({
    required this.title,
    required this.icon,
    this.onTap,
  });
}

final List<DashboardItem> dashboardItems = [
  DashboardItem(title: 'Attendance', icon: Icons.fact_check_outlined),
  DashboardItem(title: 'Leaves', icon: Icons.event_available_outlined),
  DashboardItem(title: 'Payroll', icon: Icons.account_balance_wallet_outlined),
  DashboardItem(title: 'Reports', icon: Icons.bar_chart_outlined),
  DashboardItem(title: 'Tasks', icon: Icons.task_alt_outlined),
  DashboardItem(title: 'Settings', icon: Icons.settings_outlined),
];
