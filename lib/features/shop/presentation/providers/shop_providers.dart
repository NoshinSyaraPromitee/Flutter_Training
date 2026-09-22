import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/product.dart';
import '../../repository/local_product_repository.dart';
import '../../repository/product_repository.dart';

part 'shop_providers.g.dart';

@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref) => LocalProductRepository();

@Riverpod(keepAlive: true)
List<Product> allProducts(Ref ref) =>
    ref.watch(productRepositoryProvider).list();

@Riverpod(keepAlive: true)
List<String> shopCategories(Ref ref) {
  final products = ref.watch(allProductsProvider);
  return [
    'All',
    ...{for (final p in products) p.category},
  ];
}

@Riverpod(keepAlive: true)
class ShopSearchQuery extends _$ShopSearchQuery {
  @override
  String build() => '';

  void set(String value) => state = value;
}

@Riverpod(keepAlive: true)
class ShopCategoryFilter extends _$ShopCategoryFilter {
  @override
  String build() => 'All';

  void set(String value) => state = value;
}

@Riverpod(keepAlive: true)
List<Product> filteredProducts(Ref ref) {
  final query = ref.watch(shopSearchQueryProvider).trim().toLowerCase();
  final category = ref.watch(shopCategoryFilterProvider);
  return ref.watch(allProductsProvider).where((p) {
    final matchesCategory = category == 'All' || p.category == category;
    final matchesQuery = query.isEmpty || p.name.toLowerCase().contains(query);
    return matchesCategory && matchesQuery;
  }).toList();
}

@Riverpod(keepAlive: true)
Product? productById(Ref ref, String id) {
  final products = ref.watch(allProductsProvider);
  for (final p in products) {
    if (p.id == id) return p;
  }
  return null;
}
