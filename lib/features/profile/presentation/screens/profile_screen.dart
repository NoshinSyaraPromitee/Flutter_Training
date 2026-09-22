import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_card.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plantpal/features/cart/presentation/controllers/cart_controller.dart';
import 'package:plantpal/features/gamification/domain/repositories/achievement_repository.dart';
import 'package:plantpal/features/gamification/presentation/widgets/achievements_section.dart';
import 'package:plantpal/features/plants/presentation/controllers/plants_controller.dart';
import 'package:plantpal/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _menu = <(IconData, String, String, Color)>[
    (Icons.local_florist, 'My Plants', '/plants', Color(0xFF43A047)),
    (Icons.event_available, 'Care Calendar', '/care-calendar', Color(0xFF42A5F5)),
    (Icons.eco, 'Care Guide', '/care-guide', Color(0xFF00897B)),
    (Icons.science_outlined, 'Fertilizer Recipes', '/fertilizer', Color(0xFF8BC34A)),
    (Icons.history, 'Plant History', '/plant-history', Color(0xFF8D6E63)),
    (Icons.shopping_cart, 'My Cart', '/cart', Color(0xFFFB8C00)),
    (Icons.settings, 'Settings', '/settings', Color(0xFF757575)),
  ];

  Widget _stat(String v, String l) => Expanded(
        child: Column(children: [
          Text(v, style: AppTextStyles.inter(20, w: FontWeight.w800, c: AppColors.greenPrimary)),
          Text(l, style: AppTextStyles.inter(12, c: Colors.black54)),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final plants = context.watch<PlantsController>();
    final cartCount = context.watch<CartController>().count;
    final name = context.watch<AuthController>().displayName;
    final unlocked = context.read<AchievementRepository>().getAchievements().where((a) => a.unlocked).length;

    return AppScreen(
      title: 'Profile',
      showBack: false,
      trailing: IconButton(icon: const Icon(Icons.settings_outlined, color: AppColors.greenPrimary), onPressed: () => context.push('/settings')),
      child: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(colors: [Color(0xFFFFF6DC), Color(0xFFDCE6B7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(children: [
            Row(children: [
              const CircleAvatar(radius: 34, backgroundColor: AppColors.greenPrimary, child: Icon(Icons.spa, size: 38, color: Colors.white)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(name, style: AppTextStyles.screenTitle.copyWith(fontSize: 30)),
                  Text('Plant Parent since 2026', style: AppTextStyles.inter(13, c: Colors.black54)),
                ]),
              ),
            ]),
            const SizedBox(height: 18),
            Row(children: [
              _stat('${plants.plants.length}', 'Plants'),
              _stat('${plants.averageHealth}%', 'Avg Health'),
              _stat('$unlocked', 'Badges'),
            ]),
          ]),
        ),
        const AchievementsSection(),
        const SectionTitle('Quick Menu'),
        Wrap(spacing: 12, runSpacing: 12, children: [
          for (final m in _menu)
            SizedBox(
              width: (MediaQuery.of(context).size.width - 40 - 12) / 2,
              child: AppCard(
                padding: const EdgeInsets.all(12),
                radius: 18,
                onTap: () => context.push(m.$3),
                child: Row(children: [
                  CircleAvatar(radius: 18, backgroundColor: m.$4.withValues(alpha: 0.12), child: Icon(m.$1, size: 20, color: m.$4)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(m.$2, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.inter(13, w: FontWeight.w600))),
                  if (m.$3 == '/cart' && cartCount > 0) CircleAvatar(radius: 10, backgroundColor: AppColors.danger, child: Text('$cartCount', style: const TextStyle(fontSize: 11, color: Colors.white))),
                ]),
              ),
            ),
        ]),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: () => confirmLogout(context),
          icon: const Icon(Icons.logout, color: AppColors.danger),
          label: const Text('Log Out', style: TextStyle(color: AppColors.danger)),
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: const BorderSide(color: AppColors.danger)),
        ),
      ]),
    );
  }
}