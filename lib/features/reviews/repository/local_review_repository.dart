import '../domain/review.dart';
import 'review_repository.dart';

/// No reviews backend yet (see CLAUDE.md: `Reviews` collection) — this
/// local seed stands in for a handful of pre-existing reviews.
class LocalReviewRepository implements ReviewRepository {
  @override
  Map<String, List<Review>> seed() => {
    '1': [
      Review(
        id: 'r1',
        reviewerName: 'Rahim',
        rating: 5,
        date: DateTime.now().subtract(const Duration(days: 6)),
        comment:
            'Arrived healthy and well-packaged. Already growing new leaves!',
      ),
    ],
    '4': [
      Review(
        id: 'r2',
        reviewerName: 'Ayesha',
        rating: 4,
        date: DateTime.now().subtract(const Duration(days: 2)),
        comment:
            'Good quality compost, noticeable difference in a couple of weeks.',
      ),
    ],
  };
}
