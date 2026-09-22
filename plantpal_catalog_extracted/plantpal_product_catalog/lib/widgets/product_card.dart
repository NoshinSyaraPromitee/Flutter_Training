import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product.dart';
import '../services/image_service.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.imageService,
  });

  final Product product;
  final ImageService imageService;

  Future<void> _openBuyLink(BuildContext context) async {
    final uri = Uri.parse(product.buyUrl);
    final launched = await canLaunchUrl(uri) &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open ${product.vendor}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: FutureBuilder<String?>(
              future: imageService.getImageUrl(product.imageQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const ColoredBox(
                    color: Color(0xFFF1F5F1),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                }
                final url = snapshot.data;
                if (url == null) {
                  // Unsplash key missing, offline, or no result — never
                  // block the "buy" flow on a photo.
                  return const ColoredBox(
                    color: Color(0xFFF1F5F1),
                    child: Icon(Icons.eco_outlined, size: 40, color: Color(0xFF4CAF50)),
                  );
                }
                return Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const ColoredBox(
                    color: Color(0xFFF1F5F1),
                    child: Icon(Icons.eco_outlined, size: 40, color: Color(0xFF4CAF50)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (product.scientificName != null)
                  Text(
                    product.scientificName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontStyle: FontStyle.italic, color: Colors.grey[600]),
                  ),
                const SizedBox(height: 6),
                Text(
                  product.formattedPrice,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _openBuyLink(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(
                      'View on ${product.vendor}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
