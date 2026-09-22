import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers/locale_provider.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../l10n/generated/app_localizations.dart';
import 'router/app_router.dart';

class MyPlantPalApp extends ConsumerStatefulWidget {
  const MyPlantPalApp({super.key});

  @override
  ConsumerState<MyPlantPalApp> createState() => _MyPlantPalAppState();
}

class _MyPlantPalAppState extends ConsumerState<MyPlantPalApp> {
  @override
  void initState() {
    super.initState();
    // Restore a previously-signed-in (simulated, local-only) session.
    Future.microtask(() => ref.read(authControllerProvider.notifier).restore());
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(appLocaleProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
