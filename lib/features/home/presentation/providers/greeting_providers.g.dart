// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'greeting_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// What the mascot's speech bubble should say.

@ProviderFor(greetingMessage)
final greetingMessageProvider = GreetingMessageProvider._();

/// What the mascot's speech bubble should say.

final class GreetingMessageProvider
    extends $FunctionalProvider<Greeting, Greeting, Greeting>
    with $Provider<Greeting> {
  /// What the mascot's speech bubble should say.
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

String _$greetingMessageHash() => r'f5c51a1abd5a1fb355f0c709f6039a48ab4d6028';
