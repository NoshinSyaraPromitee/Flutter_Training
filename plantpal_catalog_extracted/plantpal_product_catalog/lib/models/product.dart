/// A single catalog item (a plant, a fertilizer, a care product, etc).
///
/// This model is intentionally plain (no code generation) so it drops into
/// any Flutter project without extra build steps. All data comes from
/// `assets/data/products.json` — never hardcode a product's price or link
/// directly in a widget; add/edit it in the JSON (or via
/// `tools/catalog_manager.py add`) instead.
class Product {
  final String id;
  final String name;
  final String? scientificName;
  final String categoryId;
  final String description;

  /// Short search phrase used to fetch a representative photo at runtime
  /// (see ImageService). Not a fixed image URL — that's what makes photos
  /// easy to fix later: just edit this text, no re-scraping needed.
  final String imageQuery;

  final double price;
  final String currency;
  final String vendor;
  final String buyUrl;

  /// The date this price/link was last checked against the vendor site.
  /// Prices drift and links rot; this field is what lets the app (or you)
  /// flag entries that need a re-check instead of silently going stale.
  final DateTime lastVerified;

  const Product({
    required this.id,
    required this.name,
    this.scientificName,
    required this.categoryId,
    required this.description,
    required this.imageQuery,
    required this.price,
    required this.currency,
    required this.vendor,
    required this.buyUrl,
    required this.lastVerified,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      scientificName: json['scientificName'] as String?,
      categoryId: json['categoryId'] as String,
      description: json['description'] as String? ?? '',
      imageQuery: json['imageQuery'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      vendor: json['vendor'] as String,
      buyUrl: json['buyUrl'] as String,
      lastVerified: DateTime.parse(json['lastVerified'] as String),
    );
  }

  String get formattedPrice {
    final symbol = currency == 'USD' ? '\$' : '$currency ';
    return '$symbol${price.toStringAsFixed(2)}';
  }

  /// True once this entry hasn't been re-checked in [days] days, so a debug
  /// banner or an admin view can surface it. Defaults to ~90 days since
  /// plant/fertilizer prices don't move as fast as, say, electronics.
  bool isStale({int days = 90}) {
    return DateTime.now().difference(lastVerified).inDays > days;
  }
}
