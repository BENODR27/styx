// lib/features/dashboard/pages/inventory_audit_page.dart
import 'package:flutter/material.dart';
import 'package:styx/features/applications/inventoryAudit/widgets/inventory_drawer.dart';

class InventoryAuditPage extends StatelessWidget {
  const InventoryAuditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory Audit'),),
      drawer: const InventoryDrawer(),
      body: const Center(
        child: Text('Inventory Audit Module'),
      ),
    );
  }
}
