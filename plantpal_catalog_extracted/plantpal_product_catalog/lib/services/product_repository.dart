import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/product_category.dart';

/// Single source of truth for the product catalog.
///
/// By default this loads the bundled `assets/data/products.json`, so the
/// app works fully offline out of the box.
///
/// To update the catalog WITHOUT shipping a new app build (the whole point
/// of separating data from code), host a copy of the same JSON file
/// somewhere static — a raw GitHub URL, Firebase Hosting, S3, your own
/// server, whatever's convenient — and pass its URL as [remoteUrl]. The
/// repository tries that first and silently falls back to the bundled
/// asset if the fetch fails for any reason (offline, 404, bad JSON), so a
/// bad deploy never breaks the app.
///
/// Example:
/// ```dart
/// final repo = ProductRepository(
///   remoteUrl: 'https://raw.githubusercontent.com/you/plantpal-data/main/products.json',
/// );
/// ```
class ProductRepository {
  ProductRepository({this.remoteUrl});

  final String? remoteUrl;

  static const _assetPath = 'assets/data/products.json';

  List<Product>? _products;
  List<ProductCategory>? _categories;

  Future<void> _ensureLoaded() async {
    if (_products != null) return;

    Map<String, dynamic>? data;

    if (remoteUrl != null) {
      try {
        final response = await http
            .get(Uri.parse(remoteUrl!))
            .timeout(const Duration(seconds: 5));
        if (response.statusCode == 200) {
          data = jsonDecode(response.body) as Map<String, dynamic>;
        }
      } catch (_) {
        // No network, bad host, malformed JSON, etc. — fall back below.
      }
    }

    data ??= jsonDecode(await rootBundle.loadString(_assetPath))
        as Map<String, dynamic>;

    _categories = (data['categories'] as List)
        .map((c) => ProductCategory.fromJson(c as Map<String, dynamic>))
        .toList();

    _products = (data['products'] as List)
        .map((p) => Product.fromJson(p as Map<String, dynamic>))
        .toList();
  }

  /// Forces the next call to re-fetch/re-parse instead of using the cached
  /// in-memory copy — handy after a pull-to-refresh gesture.
  void invalidateCache() {
    _products = null;
    _categories = null;
  }

  Future<List<ProductCategory>> getCategories() async {
    await _ensureLoaded();
    return _categories!;
  }

  Future<List<Product>> getProducts({String? categoryId}) async {
    await _ensureLoaded();
    if (categoryId == null) return _products!;
    return _products!.where((p) => p.categoryId == categoryId).toList();
  }
}
