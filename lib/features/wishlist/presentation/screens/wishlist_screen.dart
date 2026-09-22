import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/net_image.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../providers/wishlist_providers.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(wishlistProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'My Wishlist',
            color: AppColors.plum,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: items.isEmpty
                ? EmptyView(
                    icon: Icons.favorite_border,
                    title: 'Your wishlist is empty',
                    subtitle: 'Tap the heart on any product to save it here.',
                    actionLabel: 'Browse Shop',
                    onAction: () => context.go('/shop'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    itemCount: items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final product = items[index];
                      return AppCard(
                        onTap: () =>
                            context.push('/shop/product/${product.id}'),
                        child: Row(
                          children: [
                            NetImage(
                              product.imageUrl,
                              width: 72,
                              height: 72,
                              radius: AppRadius.sm,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.titleMedium.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    product.category,
                                    style: AppTextStyles.caption,
                                  ),
                                  Text(
                                    taka(product.price),
                                    style: AppTextStyles.bodyText.copyWith(
                                      color: AppColors.orange,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      TextButton.icon(
                                        onPressed: () => ref
                                            .read(cartProvider.notifier)
                                            .add(product),
                                        icon: const Icon(
                                          Icons.add_shopping_cart,
                                          size: 16,
                                        ),
                                        label: const Text('Add to Cart'),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: AppColors.danger,
                                        ),
                                        onPressed: () => ref
                                            .read(wishlistProvider.notifier)
                                            .remove(product.id),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
