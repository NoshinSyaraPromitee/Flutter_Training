import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../gamification/presentation/providers/gamification_providers.dart';
import '../../../gamification/presentation/widgets/achievements_section.dart';
import '../widgets/guest_banner.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_stats_row.dart';
import '../widgets/quick_menu_grid.dart';

/// Profile tab — real signed-in user (or guest state), quick links into
/// the rest of the app, achievements, and logout.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final isGuest = auth.status == AuthStatus.guest;
    final points = ref.watch(pointsProvider);
    final unlockedCount = ref
        .watch(achievementsProvider)
        .where((a) => a.unlocked)
        .length;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: auth.displayName,
            subtitle: isGuest ? 'Browsing as guest' : auth.user?.email,
            color: AppColors.green,
            corner: IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.white),
              onPressed: () => context.push('/settings'),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                if (isGuest) const GuestBanner(),
                ProfileStatsRow(points: points, unlockedCount: unlockedCount),
                const SizedBox(height: AppSpacing.xl),
                const AchievementsSection(),
                const SizedBox(height: AppSpacing.xl),
                Text('QUICK MENU', style: AppTextStyles.sectionLabel),
                const SizedBox(height: AppSpacing.md),
                const QuickMenuGrid(),
                const SizedBox(height: AppSpacing.xl),
                const LogoutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
