import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/utils/formatters.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/net_image.dart';
import 'package:plantpal/core/widgets/quantity_stepper.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/cart/presentation/controllers/cart_controller.dart';
import 'package:plantpal/features/reviews/presentation/controllers/reviews_controller.dart';
import 'package:plantpal/features/reviews/presentation/widgets/reviews_section.dart';
import 'package:plantpal/features/shop/presentation/controllers/shop_controller.dart';
import 'package:plantpal/features/wishlist/presentation/controllers/wishlist_controller.dart';
import 'package:plantpal/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  final String productId;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _qty = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<ReviewsController>().load(widget.productId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final product = context.watch<ShopController>().byId(widget.productId);
    if (product == null) {
      return AppScreen(
        title: l10n.productFallbackTitle,
        child: ErrorView(message: l10n.productNotFoundMessage),
      );
    }


    final reviews = context.watch<ReviewsController>();
    final wishlist = context.watch<WishlistController>();
    final liked = wishlist.contains(product.id);
    final count = reviews.of(product.id).length;
    final avg =
        reviews.average(product.id)?.toStringAsFixed(1) ?? '${product.rating}';

    return AppScreen(
      title: l10n.detailsSectionTitle,
      trailing: IconButton(
        icon: Icon(
          liked ? Icons.favorite : Icons.favorite_border,
          color: liked ? AppColors.danger : AppColors.greenPrimary,
        ),
        onPressed: () => wishlist.toggle(product),
      ),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          NetImage(
            product.imageUrl,
            width: double.infinity,
            height: 260,
            radius: 24,
          ),
          const SizedBox(height: 14),
          Text(
            product.category,
            style: AppTextStyles.inter(13, c: AppColors.textMuted),
          ),
          Text(
            product.name,
            style: AppTextStyles.screenTitle.copyWith(fontSize: 30),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.star, size: 22),
              const SizedBox(width: 4),
              Text(avg, style: AppTextStyles.inter(15, w: FontWeight.w700)),
              const SizedBox(width: 6),
              Text(
                '(${l10n.productReviewsCount(count)}) • ${l10n.productInStock(product.stock)}',
                style: AppTextStyles.inter(13, c: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                taka(product.price),
                style: AppTextStyles.inter(
                  26,
                  w: FontWeight.w800,
                  c: const Color(0xFFFF9800),
                ),
              ),
              if (product.unit != null) ...[
                const SizedBox(width: 10),
                Chip(
                  avatar: const Icon(
                    Icons.scale,
                    size: 14,
                    color: AppColors.greenPrimary,
                  ),
                  label: Text(product.unit!),
                  backgroundColor: AppColors.surfaceGreen,
                ),
              ],
            ],
          ),
          SectionTitle(l10n.descriptionSectionTitle),
          Text(product.description, style: AppTextStyles.inter(14, h: 1.5)),
          SectionTitle(l10n.quantitySectionTitle),
          Row(
            children: [
              QuantityStepper(
                value: _qty,
                onMinus: () => setState(() => _qty = _qty > 1 ? _qty - 1 : 1),
                onPlus: () => setState(() => _qty++),
              ),
              if (product.unit != null) ...[
                const SizedBox(width: 12),
                Text(
                  l10n.productQuantityFormula(_qty, product.unit!),
                  style: AppTextStyles.inter(13, c: AppColors.textMuted),
                ),
              ],
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: l10n.addToCartButton,
              trailingIcon: Icons.add_shopping_cart,
              onPressed: () {
                context.read<CartController>().add(product, quantity: _qty);
                context.push('/cart');
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: l10n.buyNowButton,
              variant: AppButtonVariant.orange,
              onPressed: () {
                context.read<CartController>().add(product, quantity: _qty);
                context.push('/checkout');
              },
            ),
          ),
          ReviewsSection(productId: product.id),
        ],
      ),
    );
  }
}
