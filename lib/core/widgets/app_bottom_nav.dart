import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/l10n/app_localizations.dart';

/// The Home / Scan / Shop / AI Doctor / Profile bottom bar used across the
/// app. Pulled out as one widget so every screen renders the identical bar.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.selectedIndex, required this.onDestinationSelected});

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return NavigationBar(
      backgroundColor: Colors.white,
      indicatorColor: AppColors.greenCardFill.withValues(alpha: 0.5),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: t.navHome),
        NavigationDestination(
            icon: const Icon(Icons.photo_camera_outlined), selectedIcon: const Icon(Icons.photo_camera), label: t.navScan),
        NavigationDestination(
            icon: const Icon(Icons.shopping_bag_outlined), selectedIcon: const Icon(Icons.shopping_bag), label: t.navShop),
        NavigationDestination(
            icon: const Icon(Icons.smart_toy_outlined), selectedIcon: const Icon(Icons.smart_toy), label: t.navAiDoctor),
        NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: t.navProfile),
      ],
    );
  }
}