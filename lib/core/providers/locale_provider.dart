import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Locales the app ships UI translations for. Used to drive both
/// [MaterialApp.supportedLocales] and the language switcher UI.
const supportedLocales = [Locale('en'), Locale('bn')];

const _localeNames = {'en': 'English', 'bn': 'বাংলা'};

String localeDisplayName(Locale locale) =>
    _localeNames[locale.languageCode] ?? locale.languageCode;

/// The app's current UI language. Defaults to English; the language
/// switcher (see core/widgets/language_switcher.dart) updates this at
/// runtime via `ref.read(localeProvider.notifier).state = ...`.
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));
