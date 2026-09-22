import '../../shop/domain/product.dart';
import 'wishlist_repository.dart';

/// No wishlist-persistence backend yet (see CLAUDE.md: `Wishlists`
/// collection) — each session starts empty.
class LocalWishlistRepository implements WishlistRepository {
  @override
  List<Product> initial() => const [];
}
