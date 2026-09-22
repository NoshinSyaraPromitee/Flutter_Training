import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: color.withValues(alpha: 0.13),
        child: Icon(icon, size: 20, color: color),
      ),
      title: Text(
        title,
        style: AppTextStyles.titleMedium.copyWith(fontSize: 15),
      ),
      subtitle: Text(subtitle, style: AppTextStyles.caption),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.green,
      ),
    );
  }
}
