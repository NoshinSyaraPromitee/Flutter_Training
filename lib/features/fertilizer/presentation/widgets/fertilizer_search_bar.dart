import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/fertilizer_providers.dart';

/// Search bar for the Fertilizer screen's header `trailing` slot.
class FertilizerSearchBar extends ConsumerStatefulWidget {
  const FertilizerSearchBar({super.key});

  @override
  ConsumerState<FertilizerSearchBar> createState() =>
      _FertilizerSearchBarState();
}

class _FertilizerSearchBarState extends ConsumerState<FertilizerSearchBar> {
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
            ref.read(fertilizerSearchQueryProvider.notifier).set(value),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppColors.orange),
          suffixIcon: IconButton(
            icon: Icon(Icons.arrow_forward, color: AppColors.orange),
            onPressed: () => ref
                .read(fertilizerSearchQueryProvider.notifier)
                .set(_controller.text),
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
