import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/widgets/app_bottom_nav.dart';
import 'package:plantpal/features/plants/presentation/controllers/plants_controller.dart';
import 'package:provider/provider.dart';

/// Hosts the five shell tabs and the shared [AppBottomNav] beneath them.
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
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<PlantsController>().load());
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: widget.shell,
      bottomNavigationBar: keyboardOpen
          ? null
          : AppBottomNav(
              selectedIndex: widget.shell.currentIndex,
              onDestinationSelected: (i) => widget.shell.goBranch(i, initialLocation: i == widget.shell.currentIndex),
            ),
    );
  }
}