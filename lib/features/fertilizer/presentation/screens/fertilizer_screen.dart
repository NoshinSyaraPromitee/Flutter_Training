import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
<<<<<<< Updated upstream
=======
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/gradient_background.dart';
import 'package:plantpal/core/widgets/net_image.dart';
import 'package:plantpal/core/widgets/state_views.dart';
import 'package:plantpal/features/fertilizer/domain/entities/fertilizer.dart';
import 'package:plantpal/features/fertilizer/presentation/controllers/fertilizer_controller.dart';
import 'package:plantpal/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
>>>>>>> Stashed changes

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/fertilizer.dart';
import '../providers/fertilizer_providers.dart';

/// Fertilizer info / recipe screen, backed by the /api/v1/fertilizers
/// endpoints.
class FertilizerScreen extends ConsumerWidget {
  const FertilizerScreen({super.key});

  @override
<<<<<<< Updated upstream
  Widget build(BuildContext context, WidgetRef ref) {
    final fertilizersAsync = ref.watch(fertilizerListProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: l10n.fertilizerHeaderTitle,
            subtitle: l10n.fertilizerHeaderSubtitle,
            color: AppColors.orange,
            onBack: () => context.go('/home'),
            corner: const LanguageSwitcher(),
            trailing: const _FertilizerSearchBar(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: fertilizersAsync.when(
                data: (items) => _FertilizerList(items: items),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => _FertilizerError(error: err),
              ),
=======
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = context.watch<FertilizerController>();
    final list = c.filtered;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.fertilizerMakingTitle, textAlign: TextAlign.center, style: AppTextStyles.screenTitle),
                const SizedBox(height: 12),
                Center(child: Image.asset('assets/images/fertilizer_bag.png', width: 100, height: 100)),
                const SizedBox(height: 20),
                _FertilizerSearchBar(hint: l10n.fertilizerSearchSubtitle, onChanged: c.setQuery),
                const SizedBox(height: 16),
                Expanded(
                  child: c.loading
                      ? const LoadingView()
                      : list.isEmpty
                          ? EmptyView(icon: Icons.science_outlined, title: l10n.noRecipesFoundTitle, subtitle: l10n.noRecipesFoundBody(c.query))
                          : ListView.separated(
                              itemCount: list.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 10),
                              itemBuilder: (_, i) => _RecipeCard(item: list[i], nutrientLabel: l10n.nutrientLabel),
                            ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      label: l10n.backButton,
                      variant: AppButtonVariant.green,
                      onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
                    ),
                    AppButton(label: l10n.addFertilizerButton, variant: AppButtonVariant.orange, onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 16),
              ],
>>>>>>> Stashed changes
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              0,
              AppSpacing.xl,
              AppSpacing.xl,
            ),
            child: AppButton(
              label: l10n.addFertilizerButton,
              leadingIcon: Icons.add,
              expand: true,
              onPressed: () => _showAddFertilizerDialog(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddFertilizerDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final instructionsController = TextEditingController();

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        title: Text(l10n.addFertilizerButton),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: l10n.fertilizerNameFieldLabel,
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: l10n.fertilizerCategoryFieldLabel,
              ),
            ),
            TextField(
              controller: instructionsController,
              decoration: InputDecoration(
                labelText: l10n.fertilizerInstructionsFieldLabel,
              ),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancelButton),
          ),
          FilledButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty ||
                  instructionsController.text.trim().isEmpty) {
                return;
              }
              try {
                await ref
                    .read(fertilizerRepositoryProvider)
                    .create(
                      name: nameController.text.trim(),
                      category: categoryController.text.trim(),
                      instructions: instructionsController.text.trim(),
                    );
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop(true);
                }
              } on ApiException catch (e) {
                if (dialogContext.mounted) {
                  ScaffoldMessenger.of(
                    dialogContext,
                  ).showSnackBar(SnackBar(content: Text(e.message)));
                }
              }
            },
            child: Text(l10n.saveButton),
          ),
        ],
      ),
    );

    if (created == true) {
      ref.invalidate(fertilizerListProvider);
    }
  }
}

<<<<<<< Updated upstream
class _FertilizerSearchBar extends ConsumerStatefulWidget {
  const _FertilizerSearchBar();

  @override
  ConsumerState<_FertilizerSearchBar> createState() =>
      _FertilizerSearchBarState();
}

class _FertilizerSearchBarState extends ConsumerState<_FertilizerSearchBar> {
  late final _controller = TextEditingController(
    text: ref.read(fertilizerSearchQueryProvider),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
=======
class _FertilizerSearchBar extends StatelessWidget {
  const _FertilizerSearchBar({required this.hint, required this.onChanged});
  final String hint;
  final ValueChanged<String> onChanged;
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: TextField(
<<<<<<< Updated upstream
        controller: _controller,
        style: AppTextStyles.bodyText,
        onSubmitted: (value) =>
            ref.read(fertilizerSearchQueryProvider.notifier).state = value,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppColors.orange),
          suffixIcon: IconButton(
            icon: Icon(Icons.arrow_forward, color: AppColors.orange),
            onPressed: () =>
                ref.read(fertilizerSearchQueryProvider.notifier).state =
                    _controller.text,
          ),
          hintText: AppLocalizations.of(context).searchFertilizerHint,
          hintStyle: AppTextStyles.bodyText.copyWith(
            color: AppColors.textSecondary,
          ),
=======
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.menu),
          suffixIcon: const Icon(Icons.search),
          hintText: hint,
>>>>>>> Stashed changes
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

<<<<<<< Updated upstream
class _FertilizerList extends StatelessWidget {
  const _FertilizerList({required this.items});
  final List<Fertilizer> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context).noFertilizersFound,
          style: AppTextStyles.bodyText.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final f = items[index];
        final color = AppColors.accentRotation[index % AppColors.accentRotation.length];
        return AppCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.eco, size: 20, color: color),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(f.name, style: AppTextStyles.titleMedium),
                    if (f.category.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        f.category.toUpperCase(),
                        style: AppTextStyles.caption.copyWith(
                          color: color,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Text(f.instructions, style: AppTextStyles.bodyText),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FertilizerError extends StatelessWidget {
  const _FertilizerError({required this.error});
  final Object error;

  @override
  Widget build(BuildContext context) {
    final message = error is ApiException
        ? (error as ApiException).message
        : AppLocalizations.of(context).serverUnreachable;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 32,
              color: AppColors.textSecondary,
=======
class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.item, required this.nutrientLabel});
  final Fertilizer item;
  final String Function(String) nutrientLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.greenCardFill,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/fertilizer/${item.id}'),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            NetImage(item.imageUrl, width: 64, height: 64, radius: 10),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.name, style: AppTextStyles.inter(14, w: FontWeight.w700)),
                Text(item.purpose, style: AppTextStyles.bodyText),
                Text(nutrientLabel(item.nutrient), style: AppTextStyles.inter(11, c: AppColors.greenPrimary, w: FontWeight.w600)),
              ]),
>>>>>>> Stashed changes
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText,
            ),
          ],
        ),
      ),
    );
  }
}
