// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fertilizer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fertilizer data source. Bundled locally today; swap the
/// implementation for a REST-backed repository without touching the UI.

@ProviderFor(fertilizerRepository)
final fertilizerRepositoryProvider = FertilizerRepositoryProvider._();

/// Fertilizer data source. Bundled locally today; swap the
/// implementation for a REST-backed repository without touching the UI.

final class FertilizerRepositoryProvider
    extends
        $FunctionalProvider<
          FertilizerRepository,
          FertilizerRepository,
          FertilizerRepository
        >
    with $Provider<FertilizerRepository> {
  /// Fertilizer data source. Bundled locally today; swap the
  /// implementation for a REST-backed repository without touching the UI.
  FertilizerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fertilizerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fertilizerRepositoryHash();

  @$internal
  @override
  $ProviderElement<FertilizerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FertilizerRepository create(Ref ref) {
    return fertilizerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FertilizerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FertilizerRepository>(value),
    );
  }
}

String _$fertilizerRepositoryHash() =>
    r'67f185f2f2639f13d712c08f223854a6a5f8a2ce';

/// The full recipe catalog (bundled recipes + anything added this session).

@ProviderFor(FertilizerRecipes)
final fertilizerRecipesProvider = FertilizerRecipesProvider._();

/// The full recipe catalog (bundled recipes + anything added this session).
final class FertilizerRecipesProvider
    extends $AsyncNotifierProvider<FertilizerRecipes, FertilizerCatalog> {
  /// The full recipe catalog (bundled recipes + anything added this session).
  FertilizerRecipesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fertilizerRecipesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fertilizerRecipesHash();

  @$internal
  @override
  FertilizerRecipes create() => FertilizerRecipes();
}

String _$fertilizerRecipesHash() => r'f65ffcca73fff7812f2ff54e2d59fdecbe75f14b';

/// The full recipe catalog (bundled recipes + anything added this session).

abstract class _$FertilizerRecipes extends $AsyncNotifier<FertilizerCatalog> {
  FutureOr<FertilizerCatalog> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<FertilizerCatalog>, FertilizerCatalog>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FertilizerCatalog>, FertilizerCatalog>,
              AsyncValue<FertilizerCatalog>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Current search text for the fertilizer list.

@ProviderFor(FertilizerQuery)
final fertilizerQueryProvider = FertilizerQueryProvider._();

/// Current search text for the fertilizer list.
final class FertilizerQueryProvider
    extends $NotifierProvider<FertilizerQuery, String> {
  /// Current search text for the fertilizer list.
  FertilizerQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fertilizerQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fertilizerQueryHash();

  @$internal
  @override
  FertilizerQuery create() => FertilizerQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$fertilizerQueryHash() => r'0b592b9fc9944b52017ba1c683b61e9e388af15f';

/// Current search text for the fertilizer list.

abstract class _$FertilizerQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Recipes matching the current search query.

@ProviderFor(filteredFertilizers)
final filteredFertilizersProvider = FilteredFertilizersProvider._();

/// Recipes matching the current search query.

final class FilteredFertilizersProvider
    extends
        $FunctionalProvider<
          List<Fertilizer>,
          List<Fertilizer>,
          List<Fertilizer>
        >
    with $Provider<List<Fertilizer>> {
  /// Recipes matching the current search query.
  FilteredFertilizersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredFertilizersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredFertilizersHash();

  @$internal
  @override
  $ProviderElement<List<Fertilizer>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Fertilizer> create(Ref ref) {
    return filteredFertilizers(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Fertilizer> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Fertilizer>>(value),
    );
  }
}

String _$filteredFertilizersHash() =>
    r'b60913c360d01539537dc5cad52eb57e65439ae8';

/// A single recipe by id, or null if not found / not loaded yet.

@ProviderFor(fertilizerById)
final fertilizerByIdProvider = FertilizerByIdFamily._();

/// A single recipe by id, or null if not found / not loaded yet.

final class FertilizerByIdProvider
    extends $FunctionalProvider<Fertilizer?, Fertilizer?, Fertilizer?>
    with $Provider<Fertilizer?> {
  /// A single recipe by id, or null if not found / not loaded yet.
  FertilizerByIdProvider._({
    required FertilizerByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fertilizerByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fertilizerByIdHash();

  @override
  String toString() {
    return r'fertilizerByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Fertilizer?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Fertilizer? create(Ref ref) {
    final argument = this.argument as String;
    return fertilizerById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Fertilizer? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Fertilizer?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FertilizerByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fertilizerByIdHash() => r'21d12d2546a60519738579b5036872756a0739fc';

/// A single recipe by id, or null if not found / not loaded yet.

final class FertilizerByIdFamily extends $Family
    with $FunctionalFamilyOverride<Fertilizer?, String> {
  FertilizerByIdFamily._()
    : super(
        retry: null,
        name: r'fertilizerByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A single recipe by id, or null if not found / not loaded yet.

  FertilizerByIdProvider call(String id) =>
      FertilizerByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'fertilizerByIdProvider';
}
