// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reviewRepository)
final reviewRepositoryProvider = ReviewRepositoryProvider._();

final class ReviewRepositoryProvider
    extends
        $FunctionalProvider<
          ReviewRepository,
          ReviewRepository,
          ReviewRepository
        >
    with $Provider<ReviewRepository> {
  ReviewRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reviewRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reviewRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReviewRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReviewRepository create(Ref ref) {
    return reviewRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReviewRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReviewRepository>(value),
    );
  }
}

String _$reviewRepositoryHash() => r'82839de756b1813e2d81e4b0b8e6321f4a8527b3';

@ProviderFor(Reviews)
final reviewsProvider = ReviewsProvider._();

final class ReviewsProvider
    extends $NotifierProvider<Reviews, Map<String, List<Review>>> {
  ReviewsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reviewsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reviewsHash();

  @$internal
  @override
  Reviews create() => Reviews();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, List<Review>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, List<Review>>>(value),
    );
  }
}

String _$reviewsHash() => r'd1b5507e77e546ac912b23378e90244d52f0f47e';

abstract class _$Reviews extends $Notifier<Map<String, List<Review>>> {
  Map<String, List<Review>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<Map<String, List<Review>>, Map<String, List<Review>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, List<Review>>, Map<String, List<Review>>>,
              Map<String, List<Review>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
