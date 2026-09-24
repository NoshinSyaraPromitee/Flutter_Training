// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'greeting_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// What the mascot's speech bubble should say: prioritizes an actionable
/// plant-care nudge, falls back to a notable weather condition, and
/// otherwise greets by time of day. Returns structured data rather than a
/// localized string — the widget resolves that against [AppLocalizations].

@ProviderFor(greetingMessage)
final greetingMessageProvider = GreetingMessageProvider._();

/// What the mascot's speech bubble should say: prioritizes an actionable
/// plant-care nudge, falls back to a notable weather condition, and
/// otherwise greets by time of day. Returns structured data rather than a
/// localized string — the widget resolves that against [AppLocalizations].

final class GreetingMessageProvider
    extends $FunctionalProvider<Greeting, Greeting, Greeting>
    with $Provider<Greeting> {
  /// What the mascot's speech bubble should say: prioritizes an actionable
  /// plant-care nudge, falls back to a notable weather condition, and
  /// otherwise greets by time of day. Returns structured data rather than a
  /// localized string — the widget resolves that against [AppLocalizations].
  GreetingMessageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'greetingMessageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$greetingMessageHash();

  @$internal
  @override
  $ProviderElement<Greeting> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Greeting create(Ref ref) {
    return greetingMessage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Greeting value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Greeting>(value),
    );
  }
}

String _$greetingMessageHash() => r'284fc30d083e75807875cebbbad813167a2cfa05';
