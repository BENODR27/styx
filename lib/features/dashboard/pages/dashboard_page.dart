import 'package:flutter/material.dart';
import '../../../core/storage/local_storage.dart';
import '../../auth/pages/login_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import '../widgets/app_drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int index = 0;

  Future<void> logout() async {
    await LocalStorage.clear();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: isDesktop ? null : AppDrawer(onLogout: logout),
      body: Row(
        children: [
          if (isDesktop)
            SizedBox(width: 240, child: AppDrawer(onLogout: logout)),
          Expanded(
            child: index == 0 ? const HomePage() : const ProfilePage(),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
