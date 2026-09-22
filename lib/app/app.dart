import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
<<<<<<< Updated upstream
import 'package:flutter_riverpod/flutter_riverpod.dart';
=======
import 'package:go_router/go_router.dart';
import 'package:plantpal/app/di/app_dependencies.dart';
import 'package:plantpal/app/router/app_router.dart';
import 'package:plantpal/core/theme/app_theme.dart';
import 'package:plantpal/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plantpal/features/profile/presentation/controllers/settings_controller.dart';
import 'package:plantpal/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
>>>>>>> Stashed changes

import '../core/providers/locale_provider.dart';
import '../core/theme/app_theme.dart';
import '../l10n/generated/app_localizations.dart';
import 'router/app_router.dart';

class MyPlantPalApp extends ConsumerWidget {
  const MyPlantPalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

<<<<<<< Updated upstream
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
=======
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
>>>>>>> Stashed changes
    );
  }
}
