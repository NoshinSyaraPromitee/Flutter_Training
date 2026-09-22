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

@ProviderFor(points)
final pointsProvider = PointsProvider._();

final class PointsProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
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
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return points(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$pointsHash() => r'd5ccbdd3af75f25cf582206fb19387f406fef791';
