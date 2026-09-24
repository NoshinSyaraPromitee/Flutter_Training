import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/widgets/net_image.dart';

/// Hero photo with back + overflow-menu buttons overlaid, used at the top
/// of the plant details screen.
class PlantDetailsHeader extends StatelessWidget {
  const PlantDetailsHeader({
    super.key,
    required this.imageUrl,
    required this.onBack,
    required this.onMenuSelected,
  });

  final String imageUrl;
  final VoidCallback onBack;
  final ValueChanged<String> onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      NetImage(imageUrl, width: double.infinity, height: 300, radius: 0),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.arrow_back, color: AppColors.greenPrimary)),
              onPressed: onBack,
            ),
            PopupMenuButton<String>(
              icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.more_vert, color: AppColors.greenPrimary)),
              onSelected: onMenuSelected,
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'water', child: Text('Mark as watered')),
                PopupMenuItem(value: 'delete', child: Text('Delete plant')),
              ],
            ),
          ]),
        ),
      ),
    ]);
  }
}
