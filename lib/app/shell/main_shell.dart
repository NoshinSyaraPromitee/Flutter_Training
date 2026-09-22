import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';

/// Bottom navigation shell: Home, Scan (AI Doctor diagnosis), Shop,
/// AI Chat, Profile.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: shell,
      bottomNavigationBar: keyboardOpen
          ? null
          : NavigationBar(
              backgroundColor: Colors.white,
              indicatorColor: AppColors.green.withValues(alpha: 0.15),
              selectedIndex: shell.currentIndex,
              onDestinationSelected: (i) =>
                  shell.goBranch(i, initialLocation: i == shell.currentIndex),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.photo_camera_outlined),
                  selectedIcon: Icon(Icons.photo_camera),
                  label: 'Scan',
                ),
                NavigationDestination(
                  icon: Icon(Icons.shopping_bag_outlined),
                  selectedIcon: Icon(Icons.shopping_bag),
                  label: 'Shop',
                ),
                NavigationDestination(
                  icon: Icon(Icons.smart_toy_outlined),
                  selectedIcon: Icon(Icons.smart_toy),
                  label: 'AI Doctor',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }
}
