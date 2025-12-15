import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styx/core/network/network_speed_controller.dart';
import 'package:styx/features/splash/splash_page.dart';
import 'package:styx/shared/widgets/network_speed_badge.dart';
import 'core/storage/local_storage.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeController()..loadTheme(),
        ),
        ChangeNotifierProvider(
          create: (_) => NetworkSpeedController()..start(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeController.themeMode,

      /// 🔹 THIS IS THE KEY FIX
      builder: (context, child) {
        return Stack(
          children: [
            child!, // <- active page (Splash/Login/Dashboard)

            /// INTERNET SPEED (ALWAYS VISIBLE)
            const Positioned(
              top: 0,
              right: 5,
              child: SafeArea(
                child: NetworkSpeedBadge(),
              ),
            ),
          ],
        );
      },

      home: const SplashPage(),
    );
  }
}

