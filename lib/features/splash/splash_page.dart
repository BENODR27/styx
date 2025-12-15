import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/network/network_checker.dart';
import '../../core/storage/local_storage.dart';
import '../auth/pages/login_page.dart';
import '../dashboard/pages/dashboard_page.dart';
import 'services/version_service.dart';

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

    setState(() {
      message = 'Checking app version...';
    });

    try {
      final versionInfo = await VersionService.getLatestVersion();
      final latestVersion = versionInfo['latestVersion'] as String;
      final mandatory = versionInfo['mandatory'] as bool? ?? false;
      final msg = versionInfo['message'] as String? ?? 'Update available';
      final downloadUrl = versionInfo['downloadUrl'] as String? ?? '';

      const currentVersion = '1.0.0';

      if (_isNewVersion(currentVersion, latestVersion)) {
        await _showUpdateDialog(
          message: msg,
          mandatory: mandatory,
          downloadUrl: downloadUrl,
        );
        if (mandatory) return; // block navigation
      }

      // Optional: check network latency
      final latency = await NetworkChecker.checkLatencyMs();
      if (latency != null && latency > 2000) {
        setState(() {
          message = 'Network is slow, continuing anyway...';
        });
        await Future.delayed(const Duration(seconds: 1));
      }

      final loggedIn = await LocalStorage.isLoggedIn();
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          loggedIn ? const DashboardPage() : const LoginPage(),
        ),
      );
    } catch (e) {
      setState(() {
        message = 'Failed to check app version';
        showRetry = true;
      });
    }
  }

  bool _isNewVersion(String current, String latest) {
    final currentParts = current.split('.').map(int.parse).toList();
    final latestParts = latest.split('.').map(int.parse).toList();

    for (int i = 0; i < latestParts.length; i++) {
      if (i >= currentParts.length || latestParts[i] > currentParts[i]) {
        return true;
      } else if (latestParts[i] < currentParts[i]) {
        return false;
      }
    }
    return false;
  }

  Future<void> _showUpdateDialog({
    required String message,
    required bool mandatory,
    required String downloadUrl,
  }) async {
    if (!mounted) return;

    await showDialog(
      barrierDismissible: !mandatory,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => !mandatory,
        child: AlertDialog(
          title: const Text('Update Available'),
          content: Text(message),
          actions: [
            if (!mandatory)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // continue
                  _initialize(); // continue app flow
                },
                child: const Text('Later'),
              ),
            TextButton(
              onPressed: () async {
                if (downloadUrl.isNotEmpty) {
                  final uri = Uri.parse(downloadUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cannot open download link')),
                    );
                  }
                }
                if (!mandatory) {
                  Navigator.of(context).pop(); // optional continue
                }
              },
              child: const Text('Update'),
            ),
          ],
        ),
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
