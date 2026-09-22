import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../providers/reviews_providers.dart';

/// Reviews list + a write-a-review form, embedded on the product details
/// screen. All data is local — there's no reviews backend yet.
class ReviewsSection extends ConsumerStatefulWidget {
  const ReviewsSection({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends ConsumerState<ReviewsSection> {
  int _rating = 0;
  final _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  bool get _canSubmit => _rating > 0 && _comment.text.trim().isNotEmpty;

  void _submit() {
    ref
        .read(reviewsProvider.notifier)
        .add(widget.productId, rating: _rating, comment: _comment.text.trim());
    setState(() {
      _rating = 0;
      _comment.clear();
    });
  }

  Widget _stars(int value, {double size = 14, ValueChanged<int>? onTap}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var star = 1; star <= 5; star++)
          GestureDetector(
            onTap: onTap == null ? null : () => onTap(star),
            child: Icon(
              star <= value ? Icons.star : Icons.star_border,
              size: size,
              color: Colors.amber,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(reviewsProvider);
    final notifier = ref.read(reviewsProvider.notifier);
    final list = notifier.of(widget.productId);
    final average = notifier.averageOf(widget.productId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reviews', style: AppTextStyles.titleLarge),
            if (average != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  Text(
                    ' ${average.toStringAsFixed(1)} · ${list.length}',
                    style: AppTextStyles.bodyText.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        if (list.isEmpty)
          Text(
            'No reviews yet. Be the first to share your experience!',
            style: AppTextStyles.bodyText.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        for (final review in list) ...[
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.green,
                      child: Text(
                        review.reviewerName[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.reviewerName,
                            style: AppTextStyles.titleMedium.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            shortDate(review.date),
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    _stars(review.rating),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(review.comment, style: AppTextStyles.bodyText),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        Text('Write a Review', style: AppTextStyles.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your rating',
                style: AppTextStyles.bodyText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              _stars(
                _rating,
                size: 28,
                onTap: (value) => setState(() => _rating = value),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _comment,
                maxLines: 3,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Share your experience with this product...',
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _canSubmit ? _submit : null,
                  child: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
