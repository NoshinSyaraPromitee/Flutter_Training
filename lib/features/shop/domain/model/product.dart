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
  final String id, name, category, description, imageUrl;
  final double price, rating;
  final int stock;
  final String? unit; // e.g. "1 kg"
}

class ProductCategory {
  const ProductCategory(this.id, this.name);
  final String id, name;
}