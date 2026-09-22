// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's current UI language. Defaults to English; the language
/// switcher (see core/widgets/language_switcher.dart) updates this at
/// runtime via `ref.read(appLocaleProvider.notifier).set(...)`.

@ProviderFor(AppLocale)
final appLocaleProvider = AppLocaleProvider._();

/// The app's current UI language. Defaults to English; the language
/// switcher (see core/widgets/language_switcher.dart) updates this at
/// runtime via `ref.read(appLocaleProvider.notifier).set(...)`.
final class AppLocaleProvider extends $NotifierProvider<AppLocale, Locale> {
  /// The app's current UI language. Defaults to English; the language
  /// switcher (see core/widgets/language_switcher.dart) updates this at
  /// runtime via `ref.read(appLocaleProvider.notifier).set(...)`.
  AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  AppLocale create() => AppLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$appLocaleHash() => r'c5862a83ce916de2373bac277a08dd24ffd78a69';

/// The app's current UI language. Defaults to English; the language
/// switcher (see core/widgets/language_switcher.dart) updates this at
/// runtime via `ref.read(appLocaleProvider.notifier).set(...)`.

abstract class _$AppLocale extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
