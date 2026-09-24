// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_plants_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myPlantsRepository)
final myPlantsRepositoryProvider = MyPlantsRepositoryProvider._();

final class MyPlantsRepositoryProvider
    extends
        $FunctionalProvider<
          MyPlantsRepository,
          MyPlantsRepository,
          MyPlantsRepository
        >
    with $Provider<MyPlantsRepository> {
  MyPlantsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPlantsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPlantsRepositoryHash();

  @$internal
  @override
  $ProviderElement<MyPlantsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MyPlantsRepository create(Ref ref) {
    return myPlantsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MyPlantsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MyPlantsRepository>(value),
    );
  }
}

String _$myPlantsRepositoryHash() =>
    r'ac83643642d02bec9c0ad0bab9402d44b6c9b931';

@ProviderFor(MyPlants)
final myPlantsProvider = MyPlantsProvider._();

final class MyPlantsProvider extends $NotifierProvider<MyPlants, List<Plant>> {
  MyPlantsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPlantsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPlantsHash();

  @$internal
  @override
  MyPlants create() => MyPlants();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Plant> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Plant>>(value),
    );
  }
}

String _$myPlantsHash() => r'e13b5277d9c0ce148359abd8e2b462047d21501e';

abstract class _$MyPlants extends $Notifier<List<Plant>> {
  List<Plant> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Plant>, List<Plant>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Plant>, List<Plant>>,
              List<Plant>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Every plant's most recent scan/watering event, newest first.

@ProviderFor(plantHistory)
final plantHistoryProvider = PlantHistoryProvider._();

/// Every plant's most recent scan/watering event, newest first.

final class PlantHistoryProvider
    extends
        $FunctionalProvider<
          List<HistoryEntry>,
          List<HistoryEntry>,
          List<HistoryEntry>
        >
    with $Provider<List<HistoryEntry>> {
  /// Every plant's most recent scan/watering event, newest first.
  PlantHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plantHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plantHistoryHash();

  @$internal
  @override
  $ProviderElement<List<HistoryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<HistoryEntry> create(Ref ref) {
    return plantHistory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<HistoryEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<HistoryEntry>>(value),
    );
  }
}

String _$plantHistoryHash() => r'4406d565baa8a1c107719157b24c8552411be361';

/// Watering/fertilizing tasks grouped into today/tomorrow/later, derived
/// from each plant's watering frequency.

@ProviderFor(careTasks)
final careTasksProvider = CareTasksProvider._();

/// Watering/fertilizing tasks grouped into today/tomorrow/later, derived
/// from each plant's watering frequency.

final class CareTasksProvider
    extends $FunctionalProvider<List<CareTask>, List<CareTask>, List<CareTask>>
    with $Provider<List<CareTask>> {
  /// Watering/fertilizing tasks grouped into today/tomorrow/later, derived
  /// from each plant's watering frequency.
  CareTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'careTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$careTasksHash();

  @$internal
  @override
  $ProviderElement<List<CareTask>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<CareTask> create(Ref ref) {
    return careTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CareTask> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CareTask>>(value),
    );
  }
}

String _$careTasksHash() => r'9c56c215520b8d0bebd7f677498876acddb5d13a';
