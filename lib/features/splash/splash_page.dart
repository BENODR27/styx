import 'package:flutter/material.dart';
import '../../core/network/network_checker.dart';
import '../../core/storage/local_storage.dart';
import '../auth/pages/login_page.dart';
import '../dashboard/pages/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String message = 'Checking network...';
  bool showRetry = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    setState(() {
      message = 'Checking internet connection...';
      showRetry = false;
    });

    final hasInternet = await NetworkChecker.hasInternet();

    if (!hasInternet) {
      setState(() {
        message = 'No internet connection detected';
        showRetry = true;
      });
      return;
    }

    // OPTIONAL: latency info (do NOT block app)
    final latency = await NetworkChecker.checkLatencyMs();
    if (latency != null && latency > 2000) {
      message = 'Network is slow, continuing anyway...';
      await Future.delayed(const Duration(seconds: 1));
    }

    final loggedIn = await LocalStorage.isLoggedIn();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        loggedIn ? const DashboardPage() : const DashboardPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              if (showRetry) ...[
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _initialize,
                  child: const Text('Retry'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
