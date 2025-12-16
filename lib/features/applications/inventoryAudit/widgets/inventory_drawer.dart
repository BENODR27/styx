// lib/features/inventory/widgets/inventory_drawer.dart
import 'package:flutter/material.dart';
import 'package:styx/shared/models/drawer_item.dart';

class InventoryDrawer extends StatelessWidget {
  const InventoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      DrawerItem(
        title: 'Dashboard',
        icon: Icons.dashboard_outlined,
        onTap: () => Navigator.pop(context),
      ),
      DrawerItem(
        title: 'Audit List',
        icon: Icons.list_alt_outlined,
        onTap: () {},
      ),
      DrawerItem(
        title: 'Create Audit',
        icon: Icons.add_circle_outline,
        onTap: () {},
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
