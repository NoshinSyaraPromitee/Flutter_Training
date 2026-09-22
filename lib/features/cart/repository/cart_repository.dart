import '../domain/cart_item.dart';

abstract class CartRepository {
  List<CartItem> initial();
}
