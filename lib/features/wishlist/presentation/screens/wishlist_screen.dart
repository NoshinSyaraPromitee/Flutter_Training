import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/utils/formatters.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/net_image.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/cart/presentation/controllers/cart_controller.dart';
import 'package:plantpal/features/wishlist/presentation/controllers/wishlist_controller.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistController>();
    return AppScreen(
      title: 'My Wishlist',
      child: wishlist.items.isEmpty
          ? EmptyView(
              icon: Icons.favorite_border,
              title: 'Your wishlist is empty',
              subtitle: 'Tap the heart on any product to save it here.',
              actionLabel: 'Browse Shop',
              onAction: () => context.go('/shop'),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              itemCount: wishlist.items.length,
              itemBuilder: (_, i) {
                final p = wishlist.items[i];
                return AppCard(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  onTap: () => context.push('/shop/product/${p.id}'),
                  child: Row(children: [
                    NetImage(p.imageUrl, width: 84, height: 84),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(p.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.inter(15, w: FontWeight.w700, c: AppColors.greenPrimary)),
                        Text(p.category, style: AppTextStyles.inter(12, c: AppColors.textMuted)),
                        Text(taka(p.price), style: AppTextStyles.inter(16, w: FontWeight.w800, c: const Color(0xFFFF9800))),
                        Row(children: [
                          TextButton.icon(
                            onPressed: () => context.read<CartController>().add(p),
                            icon: const Icon(Icons.add_shopping_cart, size: 16),
                            label: const Text('Add to Cart'),
                          ),
                          const Spacer(),
                          IconButton(icon: const Icon(Icons.delete_outline, color: AppColors.danger), onPressed: () => wishlist.remove(p.id)),
                        ]),
                      ]),
                    ),
                  ]),
                );
              },
            ),
    );
  }
}