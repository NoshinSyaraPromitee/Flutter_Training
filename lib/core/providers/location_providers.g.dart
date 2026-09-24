// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The device's current coordinates, resolved once per app session
/// (re-requesting GPS on every read would be wasteful and re-prompt
/// permissions unnecessarily).

@ProviderFor(currentPosition)
final currentPositionProvider = CurrentPositionProvider._();

/// The device's current coordinates, resolved once per app session
/// (re-requesting GPS on every read would be wasteful and re-prompt
/// permissions unnecessarily).

final class CurrentPositionProvider
    extends
        $FunctionalProvider<
          AsyncValue<(double, double)>,
          (double, double),
          FutureOr<(double, double)>
        >
    with $FutureModifier<(double, double)>, $FutureProvider<(double, double)> {
  /// The device's current coordinates, resolved once per app session
  /// (re-requesting GPS on every read would be wasteful and re-prompt
  /// permissions unnecessarily).
  CurrentPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPositionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPositionHash();

  @$internal
  @override
  $FutureProviderElement<(double, double)> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<(double, double)> create(Ref ref) {
    return currentPosition(ref);
  }
}

String _$currentPositionHash() => r'7735ef1867031024f287a55070cb44136f147f2c';
