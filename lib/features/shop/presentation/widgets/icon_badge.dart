import 'package:flutter/material.dart';

/// A header icon button with a small count badge (wishlist / cart).
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Badge(
        isLabelVisible: count > 0,
        label: Text('$count'),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
