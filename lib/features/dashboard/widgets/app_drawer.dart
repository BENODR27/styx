import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_info.dart';
import '../../../core/theme/theme_controller.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const AppDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset(
                'assets/icons/app_icon.png',
                height: 84,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.pop(context),
          ),

          /// 🔹 THEME SWITCH
          SwitchListTile(
            secondary: Icon(
              themeController.isDark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            title: const Text('Dark Mode'),
            value: themeController.isDark,
            onChanged: themeController.toggleTheme,
          ),

          const Spacer(),

          /// APP VERSION
          FutureBuilder<String>(
            future: AppInfo.version(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  snapshot.data ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
