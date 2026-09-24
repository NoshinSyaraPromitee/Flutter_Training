import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../weather/open_meteo_weather_repository.dart';
import '../weather/weather.dart';
import '../weather/weather_repository.dart';
import 'location_providers.dart';

part 'weather_providers.g.dart';

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(Ref ref) => OpenMeteoWeatherRepository();

/// The current weather, cached for 1 hour rather than re-fetched on every
/// read — `keepAlive` survives widget unmounts, and the timer below
/// invalidates the cache (triggering a fresh fetch) once it goes stale.
@Riverpod(keepAlive: true)
class WeatherCache extends _$WeatherCache {
  @override
  Future<Weather> build() async {
    final timer = Timer(const Duration(hours: 1), ref.invalidateSelf);
    ref.onDispose(timer.cancel);

    final (lat, lon) = await ref.watch(currentPositionProvider.future);
    return ref.watch(weatherRepositoryProvider).current(lat: lat, lon: lon);
  }
}
