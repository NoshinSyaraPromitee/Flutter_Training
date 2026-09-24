class Review {
  const Review({required this.id, required this.name, required this.rating, required this.date, required this.comment});
  final String id, name, date, comment; // date: yyyy-mm-dd
  final int rating;
}