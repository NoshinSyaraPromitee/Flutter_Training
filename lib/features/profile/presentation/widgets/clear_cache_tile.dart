import 'package:flutter/material.dart';
import 'package:plantpal/core/cache/cache_manager.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';

class ClearCacheTile extends StatelessWidget {
  const ClearCacheTile({super.key});

  Future<void> _confirmAndClear(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear cache?'),
        content: const Text('This removes locally cached data. You won\'t lose your account or saved plants.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Clear')),
        ],
      ),
    );
    if (confirmed != true) return;
    await CacheManager.instance.clear();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cache cleared')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.textMuted.withValues(alpha: 0.13),
        child: Icon(Icons.cleaning_services_outlined, size: 20, color: AppColors.textMuted),
      ),
      title: Text('Clear Cache', style: AppTextStyles.inter(15, w: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _confirmAndClear(context),
    );
  }
}

