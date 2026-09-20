import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../domain/fertilizer.dart';
import '../providers/fertilizer_providers.dart';

/// Fertilizer info / recipe screen, backed by the /api/v1/fertilizers
/// endpoints.
class FertilizerScreen extends ConsumerWidget {
  const FertilizerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fertilizersAsync = ref.watch(fertilizerListProvider);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Fertilizer Making',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.screenTitle,
                ),
                const SizedBox(height: 12),
                Center(
                  child: Image.asset(
                    'assets/images/fertilizer_bag.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                const _FertilizerSearchBar(),
                const SizedBox(height: 20),
                Expanded(
                  child: fertilizersAsync.when(
                    data: (items) => _FertilizerList(items: items),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, _) => _FertilizerError(error: err),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      label: 'Back',
                      variant: AppButtonVariant.green,
                      onPressed: () => context.go('/home'),
                    ),
                    AppButton(
                      label: 'Add a new Fertilizer',
                      variant: AppButtonVariant.orange,
                      onPressed: () => _showAddFertilizerDialog(context, ref),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddFertilizerDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final instructionsController = TextEditingController();

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add a new Fertilizer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: instructionsController,
              decoration: const InputDecoration(labelText: 'Instructions'),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
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
            child: const Text('Save'),
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
        color: AppColors.greenCardFill.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(28),
      ),
      child: TextField(
        controller: _controller,
        onSubmitted: (value) =>
            ref.read(fertilizerSearchQueryProvider.notifier).state = value,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.menu),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                ref.read(fertilizerSearchQueryProvider.notifier).state =
                    _controller.text,
          ),
          hintText: 'Find your homemade fertilizer',
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
      return const Center(child: Text('No fertilizers found.'));
    }
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final f = items[index];
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.greenCardFill,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                f.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 6),
              Text(f.instructions, style: AppTextStyles.bodyText),
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
        : 'Could not reach the server. Is the backend running?';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}
