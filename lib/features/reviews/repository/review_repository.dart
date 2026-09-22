import '../domain/review.dart';

abstract class ReviewRepository {
  Map<String, List<Review>> seed();
}
