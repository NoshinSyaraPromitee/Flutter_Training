import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shop/domain/product.dart';
import '../../domain/cart_item.dart';
import '../../repository/cart_repository.dart';
import '../../repository/local_cart_repository.dart';

part 'cart_providers.g.dart';

@Riverpod(keepAlive: true)
CartRepository cartRepository(Ref ref) => LocalCartRepository();

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  @override
  List<CartItem> build() => ref.watch(cartRepositoryProvider).initial();

  int _indexOf(String productId) =>
      state.indexWhere((i) => i.product.id == productId);

  void add(Product product, {int quantity = 1}) {
    final i = _indexOf(product.id);
    if (i >= 0) {
      state = [
        for (var j = 0; j < state.length; j++)
          if (j == i)
            state[j].copyWith(quantity: state[j].quantity + quantity)
          else
            state[j],
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: quantity)];
    }
  }

  void increase(String productId) {
    final i = _indexOf(productId);
    if (i < 0) return;
    state = [
      for (var j = 0; j < state.length; j++)
        if (j == i)
          state[j].copyWith(quantity: state[j].quantity + 1)
        else
          state[j],
    ];
  }

  void decrease(String productId) {
    final i = _indexOf(productId);
    if (i < 0 || state[i].quantity <= 1) return;
    state = [
      for (var j = 0; j < state.length; j++)
        if (j == i)
          state[j].copyWith(quantity: state[j].quantity - 1)
        else
          state[j],
    ];
  }

  void remove(String productId) {
    state = state.where((i) => i.product.id != productId).toList();
  }

  void clear() => state = const [];
}

@riverpod
double cartSubtotal(Ref ref) {
  final items = ref.watch(cartProvider);
  return items.fold<double>(0, (sum, item) => sum + item.lineTotal);
}

@riverpod
int cartCount(Ref ref) => ref.watch(cartProvider).length;
