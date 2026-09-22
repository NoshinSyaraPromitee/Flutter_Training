/// A shop product. There's no products backend yet, so this is served
/// from a small local catalog — see [LocalProductRepository].
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.stock,
    required this.description,
    required this.imageUrl,
    this.unit,
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int stock;
  final String description;
  final String imageUrl;
  final String? unit; // e.g. "1 kg"
}
