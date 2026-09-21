import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/locale_provider.dart';
import '../theme/app_spacing.dart';

/// A small pill button that opens a menu to switch the app's UI language.
/// Meant to sit in a [CurvedHeader]'s `corner` slot.
class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return PopupMenuButton<Locale>(
      initialValue: currentLocale,
      tooltip: 'Language',
      onSelected: (locale) =>
          ref.read(localeProvider.notifier).state = locale,
      itemBuilder: (context) => [
        for (final locale in supportedLocales)
          PopupMenuItem(
            value: locale,
            child: Text(localeDisplayName(locale)),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, color: Colors.white, size: 16),
            const SizedBox(width: 4),
            Text(
              currentLocale.languageCode.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
