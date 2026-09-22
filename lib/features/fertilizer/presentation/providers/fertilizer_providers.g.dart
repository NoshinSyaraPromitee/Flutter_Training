// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fertilizer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fertilizerRepository)
final fertilizerRepositoryProvider = FertilizerRepositoryProvider._();

final class FertilizerRepositoryProvider
    extends
        $FunctionalProvider<
          FertilizerRepository,
          FertilizerRepository,
          FertilizerRepository
        >
    with $Provider<FertilizerRepository> {
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
    r'a00738e8dc24d2d82bfb6b90ec36564209c92a29';

/// The current text in the fertilizer search bar.

@ProviderFor(FertilizerSearchQuery)
final fertilizerSearchQueryProvider = FertilizerSearchQueryProvider._();

/// The current text in the fertilizer search bar.
final class FertilizerSearchQueryProvider
    extends $NotifierProvider<FertilizerSearchQuery, String> {
  /// The current text in the fertilizer search bar.
  FertilizerSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fertilizerSearchQueryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fertilizerSearchQueryHash();

  @$internal
  @override
  FertilizerSearchQuery create() => FertilizerSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$fertilizerSearchQueryHash() =>
    r'8de6ff9f6ddd3165d42687529c270c899666fb5c';

/// The current text in the fertilizer search bar.

abstract class _$FertilizerSearchQuery extends $Notifier<String> {
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

/// Fetches fertilizers matching [fertilizerSearchQueryProvider]. Re-runs
/// automatically whenever the query changes.

@ProviderFor(fertilizerList)
final fertilizerListProvider = FertilizerListProvider._();

/// Fetches fertilizers matching [fertilizerSearchQueryProvider]. Re-runs
/// automatically whenever the query changes.

final class FertilizerListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Fertilizer>>,
          List<Fertilizer>,
          FutureOr<List<Fertilizer>>
        >
    with $FutureModifier<List<Fertilizer>>, $FutureProvider<List<Fertilizer>> {
  /// Fetches fertilizers matching [fertilizerSearchQueryProvider]. Re-runs
  /// automatically whenever the query changes.
  FertilizerListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fertilizerListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fertilizerListHash();

  @$internal
  @override
  $FutureProviderElement<List<Fertilizer>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Fertilizer>> create(Ref ref) {
    return fertilizerList(ref);
  }
}

String _$fertilizerListHash() => r'8147121d9195a9a2b48a43375bfa860bf916eb7c';
