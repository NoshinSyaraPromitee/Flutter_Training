import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/fertilizer_providers.dart';
import '../widgets/add_fertilizer_dialog.dart';
import '../widgets/fertilizer_error.dart';
import '../widgets/fertilizer_list.dart';
import '../widgets/fertilizer_search_bar.dart';

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
            trailing: const FertilizerSearchBar(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: fertilizersAsync.when(
                data: (items) => FertilizerList(items: items),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => FertilizerError(error: err),
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
              onPressed: () => showAddFertilizerDialog(context, ref),
            ),
          ),
        ],
      ),
    );
  }
}
