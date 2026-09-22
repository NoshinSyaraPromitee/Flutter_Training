import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

/// Locales the app ships UI translations for. Used to drive both
/// [MaterialApp.supportedLocales] and the language switcher UI.
const supportedLocales = [Locale('en'), Locale('bn')];

const _localeNames = {'en': 'English', 'bn': 'বাংলা'};

String localeDisplayName(Locale locale) =>
    _localeNames[locale.languageCode] ?? locale.languageCode;

/// The app's current UI language. Defaults to English; the language
/// switcher (see core/widgets/language_switcher.dart) updates this at
/// runtime via `ref.read(appLocaleProvider.notifier).set(...)`.
@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale build() => const Locale('en');

  void set(Locale locale) => state = locale;
}
