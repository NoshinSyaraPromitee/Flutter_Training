// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_tip_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// An extra watering tip for today's weather, layered on top of the
/// roadmap's baseline [baseWaterMl] guidance. Returns null when the
/// weather isn't notable enough to warrant overriding the baseline tip.

@ProviderFor(weatherTip)
final weatherTipProvider = WeatherTipFamily._();

/// An extra watering tip for today's weather, layered on top of the
/// roadmap's baseline [baseWaterMl] guidance. Returns null when the
/// weather isn't notable enough to warrant overriding the baseline tip.

final class WeatherTipProvider
    extends $FunctionalProvider<WeatherTip?, WeatherTip?, WeatherTip?>
    with $Provider<WeatherTip?> {
  /// An extra watering tip for today's weather, layered on top of the
  /// roadmap's baseline [baseWaterMl] guidance. Returns null when the
  /// weather isn't notable enough to warrant overriding the baseline tip.
  WeatherTipProvider._({
    required WeatherTipFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'weatherTipProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$weatherTipHash();

  @override
  String toString() {
    return r'weatherTipProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<WeatherTip?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WeatherTip? create(Ref ref) {
    final argument = this.argument as int;
    return weatherTip(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherTip? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherTip?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WeatherTipProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weatherTipHash() => r'03af370977341b93c7398d70f05766ad13a02dbd';

/// An extra watering tip for today's weather, layered on top of the
/// roadmap's baseline [baseWaterMl] guidance. Returns null when the
/// weather isn't notable enough to warrant overriding the baseline tip.

final class WeatherTipFamily extends $Family
    with $FunctionalFamilyOverride<WeatherTip?, int> {
  WeatherTipFamily._()
    : super(
        retry: null,
        name: r'weatherTipProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// An extra watering tip for today's weather, layered on top of the
  /// roadmap's baseline [baseWaterMl] guidance. Returns null when the
  /// weather isn't notable enough to warrant overriding the baseline tip.

  WeatherTipProvider call(int baseWaterMl) =>
      WeatherTipProvider._(argument: baseWaterMl, from: this);

  @override
  String toString() => r'weatherTipProvider';
}
