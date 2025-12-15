// lib/features/dashboard/pages/home_page.dart
import 'package:flutter/material.dart';
import '../data/dashboard_items.dart';
import '../widgets/dashboard_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int columns;
    if (width < 600) {
      columns = 1; // mobile portrait
    } else if (width < 900) {
      columns = 2; // mobile landscape
    } else if (width < 1200) {
      columns = 3; // tablet
    } else {
      columns = 4; // desktop
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: dashboardItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          return DashboardCard(item: dashboardItems[index]);
        },
      ),
    );
  }
}
