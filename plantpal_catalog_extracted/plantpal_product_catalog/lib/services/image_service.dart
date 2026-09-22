import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Fetches a representative photo for a product from the Unsplash API and
/// caches the result on-device so the same search query is never fetched
/// twice. This is what covers the "photo" part of the catalog without
/// hardcoding (and eventually breaking) a scraped image URL per product.
///
/// Setup (free, ~2 minutes, no approval needed for the Demo tier):
///   1. Create an account at https://unsplash.com/developers
///   2. "New Application" -> copy the Access Key
///   3. Pass it in as [accessKey] below
///
/// The Demo tier is rate-limited to 50 requests/hour, which is normally
/// plenty here since every query is cached after its first successful
/// fetch — a catalog of 100 products only ever costs 100 requests, total,
/// ever (until you clear app data). If you outgrow that, Unsplash's
/// "Apply for Production" flow raises the limit substantially, for free.
///
/// If [accessKey] is left empty, or a request fails for any reason (no
/// internet, rate limit hit, no results), this returns null and the
/// caller should show a placeholder — see ProductCard for an example.
class ImageService {
  ImageService({required this.accessKey});

  final String accessKey;
  static const _cacheKeyPrefix = 'unsplash_image_';

  Future<String?> getImageUrl(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = '$_cacheKeyPrefix${query.toLowerCase()}';

    final cached = prefs.getString(cacheKey);
    if (cached != null) return cached;

    if (accessKey.isEmpty) return null;

    try {
      final uri = Uri.https('api.unsplash.com', '/search/photos', {
        'query': query,
        'per_page': '1',
        'orientation': 'squarish',
      });
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Client-ID $accessKey'},
      ).timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) return null;

      final results = jsonDecode(response.body)['results'] as List;
      if (results.isEmpty) return null;

      final url = results.first['urls']['regular'] as String;
      await prefs.setString(cacheKey, url);
      return url;
    } catch (_) {
      return null;
    }
  }
}
