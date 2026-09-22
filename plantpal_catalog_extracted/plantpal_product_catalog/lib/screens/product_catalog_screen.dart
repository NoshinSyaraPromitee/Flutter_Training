import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/product_category.dart';
import '../services/image_service.dart';
import '../services/product_repository.dart';
import '../widgets/product_card.dart';

/// Drop-in shop screen. Wire it into your app like:
/// ```dart
/// ProductCatalogScreen(
///   repository: ProductRepository(),
///   imageService: ImageService(accessKey: 'YOUR_UNSPLASH_ACCESS_KEY'),
/// )
/// ```
/// It doesn't assume Provider/Riverpod/Bloc/GetX — both services are passed
/// in as plain constructor args, so wire them however your app already
/// manages dependencies (a service locator, a provider above this widget,
/// or just constructing them once in main() and passing them down).
class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({
    super.key,
    required this.repository,
    required this.imageService,
  });

  final ProductRepository repository;
  final ImageService imageService;

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _CatalogData {
  final List<ProductCategory> categories;
  final List<Product> products;
  _CatalogData(this.categories, this.products);
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  String? _selectedCategoryId;
  late Future<_CatalogData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_CatalogData> _load() async {
    final categories = await widget.repository.getCategories();
    final products = await widget.repository.getProducts();
    return _CatalogData(categories, products);
  }

  Future<void> _refresh() async {
    widget.repository.invalidateCache();
    setState(() => _future = _load());
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: FutureBuilder<_CatalogData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Could not load the catalog: ${snapshot.error}'),
              ),
            );
          }

          final data = snapshot.data!;
          final visible = _selectedCategoryId == null
              ? data.products
              : data.products
                  .where((p) => p.categoryId == _selectedCategoryId)
                  .toList();

          return RefreshIndicator(
            onRefresh: _refresh,
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      _CategoryChip(
                        label: 'All',
                        selected: _selectedCategoryId == null,
                        onTap: () => setState(() => _selectedCategoryId = null),
                      ),
                      for (final c in data.categories)
                        _CategoryChip(
                          label: c.name,
                          selected: _selectedCategoryId == c.id,
                          onTap: () => setState(() => _selectedCategoryId = c.id),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.62,
                    ),
                    itemCount: visible.length,
                    itemBuilder: (context, i) => ProductCard(
                      product: visible[i],
                      imageService: widget.imageService,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
