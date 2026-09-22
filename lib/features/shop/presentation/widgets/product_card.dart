import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/net_image.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../wishlist/presentation/providers/wishlist_providers.dart';
import '../../domain/product.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(
      wishlistProvider.select((items) => items.any((p) => p.id == product.id)),
    );

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      onTap: () => context.push('/shop/product/${product.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Positioned.fill(child: NetImage(product.imageUrl)),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 3),
                        Text(
                          '${product.rating}',
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: InkWell(
                    onTap: () =>
                        ref.read(wishlistProvider.notifier).toggle(product),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: liked ? AppColors.danger : AppColors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.titleMedium.copyWith(fontSize: 14),
          ),
          Text(product.category, style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                taka(product.price),
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.orange,
                ),
              ),
              InkWell(
                onTap: () {
                  ref.read(cartProvider.notifier).add(product);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.green,
                  child: const Icon(
                    Icons.add_shopping_cart,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
