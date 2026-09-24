import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'di/app_dependencies.dart';
import 'router/app_router.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/profile/presentation/controllers/settings_controller.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PlantPalApp extends StatefulWidget {
  const PlantPalApp({super.key});
  @override
  State<PlantPalApp> createState() => _PlantPalAppState();
}

class _PlantPalAppState extends State<PlantPalApp> {
  final AppDependencies _deps = AppDependencies();
  late final GoRouter _router = AppRouter.create(_deps.auth);

  @override
  void initState() {
    super.initState();
    _deps.auth.addListener(_onAuthChanged);
    _deps.auth.init(); // restore saved session
  }

  /// Drop per-user state when the session ends.
  void _onAuthChanged() {
    if (_deps.auth.status == AuthStatus.unauthenticated) {
      _deps.plants.clear();
      _deps.cart.clear();
      _deps.wishlist.clear();
    }
  }

  @override
  void dispose() {
    _deps.auth.removeListener(_onAuthChanged);
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _deps.providers,
      child: Consumer<SettingsController>(
        builder: (context, settings, _) => MaterialApp.router(
          title: 'PlantPal',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          routerConfig: _router,
          locale: Locale(settings.language),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}