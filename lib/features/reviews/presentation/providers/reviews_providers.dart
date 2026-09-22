import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/review.dart';
import '../../repository/local_review_repository.dart';
import '../../repository/review_repository.dart';

part 'reviews_providers.g.dart';

@Riverpod(keepAlive: true)
ReviewRepository reviewRepository(Ref ref) => LocalReviewRepository();

@Riverpod(keepAlive: true)
class Reviews extends _$Reviews {
  @override
  Map<String, List<Review>> build() =>
      ref.watch(reviewRepositoryProvider).seed();

  List<Review> of(String productId) => state[productId] ?? const [];

  double? averageOf(String productId) {
    final list = of(productId);
    if (list.isEmpty) return null;
    return list.map((r) => r.rating).reduce((a, b) => a + b) / list.length;
  }

  void add(String productId, {required int rating, required String comment}) {
    final review = Review(
      id: 'r${DateTime.now().microsecondsSinceEpoch}',
      reviewerName: 'You',
      rating: rating,
      date: DateTime.now(),
      comment: comment,
    );
    state = {
      ...state,
      productId: [review, ...of(productId)],
    };
  }
}
