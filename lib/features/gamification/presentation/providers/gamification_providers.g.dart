// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(achievementRepository)
final achievementRepositoryProvider = AchievementRepositoryProvider._();

final class AchievementRepositoryProvider
    extends
        $FunctionalProvider<
          AchievementRepository,
          AchievementRepository,
          AchievementRepository
        >
    with $Provider<AchievementRepository> {
  AchievementRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'achievementRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$achievementRepositoryHash();

  @$internal
  @override
  $ProviderElement<AchievementRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AchievementRepository create(Ref ref) {
    return achievementRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AchievementRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AchievementRepository>(value),
    );
  }
}

String _$achievementRepositoryHash() =>
    r'9186704141a076ac6e5d4fd6f3e5d6f77099afd8';

@ProviderFor(achievements)
final achievementsProvider = AchievementsProvider._();

final class AchievementsProvider
    extends
        $FunctionalProvider<
          List<Achievement>,
          List<Achievement>,
          List<Achievement>
        >
    with $Provider<List<Achievement>> {
  AchievementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'achievementsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$achievementsHash();

  @$internal
  @override
  $ProviderElement<List<Achievement>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Achievement> create(Ref ref) {
    return achievements(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Achievement> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Achievement>>(value),
    );
  }
}

String _$achievementsHash() => r'54f3dbf9504f9457169461254ab75f1331df5f0c';

/// The user's earned-points balance — starts at whatever the unlocked
/// achievements are worth, then grows as care tasks are completed (see
/// [MyPlants.markWatered]). No points backend exists yet (see CLAUDE.md:
/// point-balance changes must be validated server-side eventually), so
/// this is an in-memory, session-local balance for now.

@ProviderFor(Points)
final pointsProvider = PointsProvider._();

/// The user's earned-points balance — starts at whatever the unlocked
/// achievements are worth, then grows as care tasks are completed (see
/// [MyPlants.markWatered]). No points backend exists yet (see CLAUDE.md:
/// point-balance changes must be validated server-side eventually), so
/// this is an in-memory, session-local balance for now.
final class PointsProvider extends $NotifierProvider<Points, int> {
  /// The user's earned-points balance — starts at whatever the unlocked
  /// achievements are worth, then grows as care tasks are completed (see
  /// [MyPlants.markWatered]). No points backend exists yet (see CLAUDE.md:
  /// point-balance changes must be validated server-side eventually), so
  /// this is an in-memory, session-local balance for now.
  PointsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pointsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pointsHash();

  @$internal
  @override
  Points create() => Points();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$pointsHash() => r'b857dc919ffed4ae7f3c844b02c2caa3441fb372';

/// The user's earned-points balance — starts at whatever the unlocked
/// achievements are worth, then grows as care tasks are completed (see
/// [MyPlants.markWatered]). No points backend exists yet (see CLAUDE.md:
/// point-balance changes must be validated server-side eventually), so
/// this is an in-memory, session-local balance for now.

abstract class _$Points extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
