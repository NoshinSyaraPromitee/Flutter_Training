import 'dart:convert';

import 'package:http/http.dart' as http;

import 'weather.dart';
import 'weather_repository.dart';

/// Talks directly to Open Meteo (https://open-meteo.com) rather than going
/// through the Go backend — it's a free, keyless, public API, unlike the
/// AI/Cloudinary/payment providers CLAUDE.md requires routing server-side.
class OpenMeteoWeatherRepository implements WeatherRepository {
  static const _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  @override
  Future<Weather> current({required double lat, required double lon}) async {
    final uri = Uri.parse(
      '$_baseUrl?latitude=$lat&longitude=$lon&current_weather=true&timezone=auto',
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Open Meteo request failed: ${response.statusCode}');
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final current = body['current_weather'] as Map<String, dynamic>;
    return Weather(
      temperatureC: (current['temperature'] as num).toDouble(),
      condition: weatherConditionFromCode(current['weathercode'] as int),
      isDay: (current['is_day'] as int) == 1,
      fetchedAt: DateTime.now(),
    );
  }
}
