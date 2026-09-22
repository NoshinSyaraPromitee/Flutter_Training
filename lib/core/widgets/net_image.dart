import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A network image with a themed placeholder/error fallback — used for
/// shop product photos and other remote images that don't exist yet
/// (this app has no image hosting wired up, so this is future-proofing).
class NetImage extends StatelessWidget {
  const NetImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.radius = 16,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit fit;

  Widget _box(Widget child) => Container(
    width: width,
    height: height,
    color: AppColors.green.withValues(alpha: 0.08),
    alignment: Alignment.center,
    child: child,
  );

  Widget _placeholder() =>
      _box(Icon(Icons.local_florist, color: AppColors.green));

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: url.isEmpty
          ? _placeholder()
          : Image.network(
              url,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (_, _, _) => _placeholder(),
              loadingBuilder: (_, child, progress) => progress == null
                  ? child
                  : _box(
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
            ),
    );
  }
}
