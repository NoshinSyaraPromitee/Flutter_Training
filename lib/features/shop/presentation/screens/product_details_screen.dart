import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/net_image.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../reviews/presentation/widgets/reviews_section.dart';
import '../../../wishlist/presentation/providers/wishlist_providers.dart';
import '../providers/shop_providers.dart';
import '../widgets/product_actions.dart';
import '../widgets/product_price_meta.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productByIdProvider(widget.productId));

    if (product == null) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurvedHeader(
              title: 'Product',
              color: AppColors.plum,
              onBack: () => context.pop(),
            ),
            const Expanded(
              child: EmptyView(
                icon: Icons.error_outline,
                title: 'Product not found.',
              ),
            ),
          ],
        ),
      );
    }

    final liked = ref.watch(
      wishlistProvider.select((items) => items.any((p) => p.id == product.id)),
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: product.name,
            color: AppColors.plum,
            onBack: () => context.pop(),
            corner: IconButton(
              icon: Icon(
                liked ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () =>
                  ref.read(wishlistProvider.notifier).toggle(product),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                NetImage(
                  product.imageUrl,
                  width: double.infinity,
                  height: 220,
                  radius: AppRadius.md,
                ),
                const SizedBox(height: AppSpacing.lg),
                ProductPriceMeta(product: product),
                const SizedBox(height: AppSpacing.lg),
                Text('Description', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(product.description, style: AppTextStyles.bodyText),
                const SizedBox(height: AppSpacing.lg),
                Text('Quantity', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                ProductActions(
                  quantity: _quantity,
                  onMinus: () => setState(
                    () => _quantity = _quantity > 1 ? _quantity - 1 : 1,
                  ),
                  onPlus: () => setState(() => _quantity++),
                  onAddToCart: () {
                    ref
                        .read(cartProvider.notifier)
                        .add(product, quantity: _quantity);
                    context.push('/cart');
                  },
                  onBuyNow: () {
                    ref
                        .read(cartProvider.notifier)
                        .add(product, quantity: _quantity);
                    context.push('/checkout');
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                ReviewsSection(productId: product.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
