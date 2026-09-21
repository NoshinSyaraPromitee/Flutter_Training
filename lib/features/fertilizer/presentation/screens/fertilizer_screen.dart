import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: TextField(
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
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

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
