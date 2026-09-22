import 'package:flutter/material.dart';
import 'package:plantpal/core/theme/app_colors.dart';

class NetImage extends StatelessWidget {
  const NetImage(this.url, {super.key, this.width, this.height, this.radius = 16, this.fit = BoxFit.cover});
  final String url;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit fit;

  Widget _box(Widget c) =>
      Container(width: width, height: height, color: AppColors.surfaceGreen, alignment: Alignment.center, child: c);

  Widget _placeholder() => _box(const Icon(Icons.local_florist, color: AppColors.greenPrimary));

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: url.isEmpty
            ? _placeholder()
            : Image.network(
                url,
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (_, __, ___) => _placeholder(),
                loadingBuilder: (_, child, p) => p == null
                    ? child
                    : _box(const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
              ),
      );
}