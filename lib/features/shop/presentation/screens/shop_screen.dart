import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../wishlist/presentation/providers/wishlist_providers.dart';
import '../providers/shop_providers.dart';
import '../widgets/icon_badge.dart';
import '../widgets/product_card.dart';

/// Shop tab: local product catalog with search/category filtering.
class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(filteredProductsProvider);
    final categories = ref.watch(shopCategoriesProvider);
    final selectedCategory = ref.watch(shopCategoryFilterProvider);
    final cartCount = ref.watch(cartCountProvider);
    final wishlistCount = ref.watch(wishlistProvider).length;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'Shop',
            subtitle: 'Find your necessary gardening equipment.',
            color: AppColors.plum,
            corner: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconBadge(
                  icon: Icons.favorite_border,
                  count: wishlistCount,
                  onTap: () => context.push('/wishlist'),
                ),
                IconBadge(
                  icon: Icons.shopping_cart_outlined,
                  count: cartCount,
                  onTap: () => context.push('/cart'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.sm,
            ),
            child: AppTextField(
              hint: 'Search products...',
              icon: Icons.search,
              onChanged: (value) =>
                  ref.read(shopSearchQueryProvider.notifier).set(value),
            ),
          ),
          SizedBox(
            height: 42,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              scrollDirection: Axis.horizontal,
              children: [
                for (final category in categories)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (_) => ref
                          .read(shopCategoryFilterProvider.notifier)
                          .set(category),
                      selectedColor: AppColors.green,
                      backgroundColor: Colors.white,
                      showCheckmark: false,
                      labelStyle: AppTextStyles.bodyText.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: selectedCategory == category
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: products.isEmpty
                ? const EmptyView(
                    icon: Icons.search_off,
                    title: 'No products found',
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.sm,
                      AppSpacing.xl,
                      AppSpacing.xl,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: AppSpacing.md,
                          crossAxisSpacing: AppSpacing.md,
                          childAspectRatio: 0.6,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) =>
                        ProductCard(product: products[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
