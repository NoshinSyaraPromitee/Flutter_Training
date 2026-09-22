import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shop/domain/product.dart';
import '../../repository/local_wishlist_repository.dart';
import '../../repository/wishlist_repository.dart';

part 'wishlist_providers.g.dart';

@Riverpod(keepAlive: true)
WishlistRepository wishlistRepository(Ref ref) => LocalWishlistRepository();

@Riverpod(keepAlive: true)
class Wishlist extends _$Wishlist {
  @override
  List<Product> build() => ref.watch(wishlistRepositoryProvider).initial();

  bool contains(String productId) => state.any((p) => p.id == productId);

  void toggle(Product product) {
    if (contains(product.id)) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  void remove(String productId) =>
      state = state.where((p) => p.id != productId).toList();

  void clear() => state = const [];
}
