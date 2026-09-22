class Review {
  const Review({
    required this.id,
    required this.reviewerName,
    required this.rating,
    required this.date,
    required this.comment,
  });

  final String id;
  final String reviewerName;
  final int rating;
  final DateTime date;
  final String comment;
}
