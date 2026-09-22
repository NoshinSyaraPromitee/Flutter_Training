/// A category used to group products (e.g. "Houseplants",
/// "Plant Food & Fertilizer"). Categories live in the JSON data file, not in
/// Dart code, so adding a new one is a data change, not a code change.
class ProductCategory {
  final String id;
  final String name;

  const ProductCategory({required this.id, required this.name});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
