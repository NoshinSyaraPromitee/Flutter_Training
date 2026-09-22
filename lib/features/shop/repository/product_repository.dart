import '../domain/product.dart';

abstract class ProductRepository {
  List<Product> list();
}
