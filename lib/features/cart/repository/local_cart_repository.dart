import '../domain/cart_item.dart';
import 'cart_repository.dart';

/// No cart-persistence backend yet (see CLAUDE.md: `Carts` collection) —
/// each session starts with an empty cart.
class LocalCartRepository implements CartRepository {
  @override
  List<CartItem> initial() => const [];
}
