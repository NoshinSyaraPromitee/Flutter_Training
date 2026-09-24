// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weatherRepository)
final weatherRepositoryProvider = WeatherRepositoryProvider._();

final class WeatherRepositoryProvider
    extends
        $FunctionalProvider<
          WeatherRepository,
          WeatherRepository,
          WeatherRepository
        >
    with $Provider<WeatherRepository> {
  WeatherRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherRepositoryHash();

  @$internal
  @override
  $ProviderElement<WeatherRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeatherRepository create(Ref ref) {
    return weatherRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherRepository>(value),
    );
  }
}

String _$weatherRepositoryHash() => r'1664233130f632a6b24b6ce1b9dfecbe2f0a51be';

/// The current weather, cached for 1 hour rather than re-fetched on every
/// read — `keepAlive` survives widget unmounts, and the timer below
/// invalidates the cache (triggering a fresh fetch) once it goes stale.

@ProviderFor(WeatherCache)
final weatherCacheProvider = WeatherCacheProvider._();

/// The current weather, cached for 1 hour rather than re-fetched on every
/// read — `keepAlive` survives widget unmounts, and the timer below
/// invalidates the cache (triggering a fresh fetch) once it goes stale.
final class WeatherCacheProvider
    extends $AsyncNotifierProvider<WeatherCache, Weather> {
  /// The current weather, cached for 1 hour rather than re-fetched on every
  /// read — `keepAlive` survives widget unmounts, and the timer below
  /// invalidates the cache (triggering a fresh fetch) once it goes stale.
  WeatherCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherCacheHash();

  @$internal
  @override
  WeatherCache create() => WeatherCache();
}

String _$weatherCacheHash() => r'20ca09d46eaaa053eefc2b9caf45e5aee8e3859e';

/// The current weather, cached for 1 hour rather than re-fetched on every
/// read — `keepAlive` survives widget unmounts, and the timer below
/// invalidates the cache (triggering a fresh fetch) once it goes stale.

abstract class _$WeatherCache extends $AsyncNotifier<Weather> {
  FutureOr<Weather> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Weather>, Weather>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Weather>, Weather>,
              AsyncValue<Weather>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
