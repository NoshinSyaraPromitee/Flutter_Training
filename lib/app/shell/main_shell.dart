import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../features/plants/presentation/controllers/plants_controller.dart';
import '../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

/// Bottom navigation: Home (Main Menu), Scan, Shop, AI Doctor, Profile.
class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.shell});
  final StatefulNavigationShell shell;
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<PlantsController>().load(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // The Main Menu (tab 0) draws its own Camera / Chat / Back bar.
    final hideBar = keyboardOpen || widget.shell.currentIndex == 0;
    return Scaffold(
      body: widget.shell,
      bottomNavigationBar: hideBar
          ? null
          : NavigationBar(
              backgroundColor: Colors.white,
              indicatorColor: AppColors.greenCardFill.withValues(alpha: 0.5),
              selectedIndex: widget.shell.currentIndex,
              onDestinationSelected: (i) => widget.shell.goBranch(
                i,
                initialLocation: i == widget.shell.currentIndex,
              ),
              destinations: [
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
                  label: l10n.shopMenuLabel,
                ),
                NavigationDestination(
                  icon: Icon(Icons.smart_toy_outlined),
                  selectedIcon: Icon(Icons.smart_toy),
                  label: l10n.aiDoctorMenuLabel,
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: l10n.profileTitle,
                ),
              ],
            ),
    );
  }
}
