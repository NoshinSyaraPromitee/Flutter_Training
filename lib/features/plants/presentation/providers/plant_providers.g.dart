// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(plantRepository)
final plantRepositoryProvider = PlantRepositoryProvider._();

final class PlantRepositoryProvider
    extends
        $FunctionalProvider<PlantRepository, PlantRepository, PlantRepository>
    with $Provider<PlantRepository> {
  PlantRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plantRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plantRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlantRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlantRepository create(Ref ref) {
    return plantRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlantRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlantRepository>(value),
    );
  }
}

String _$plantRepositoryHash() => r'615fc3ac386fd1c797d10d1d13ea05ea13a7ee33';
