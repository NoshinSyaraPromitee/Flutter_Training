/// A homemade fertilizer recipe, as returned by the backend's
/// /api/v1/fertilizers endpoints.
class Fertilizer {
  const Fertilizer({
    required this.id,
    required this.name,
    required this.category,
    required this.instructions,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String category;
  final String instructions;
  final DateTime createdAt;

  factory Fertilizer.fromJson(Map<String, dynamic> json) {
    return Fertilizer(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String? ?? '',
      instructions: json['instructions'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
