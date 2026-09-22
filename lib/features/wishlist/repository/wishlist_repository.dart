import '../../shop/domain/product.dart';

abstract class WishlistRepository {
  List<Product> initial();
}
