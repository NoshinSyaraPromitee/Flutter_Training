import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/weather_providers.dart';
import '../../../../core/weather/weather.dart';
import '../../domain/weather_tip.dart';

part 'weather_tip_providers.g.dart';

const _hotThresholdC = 35.0;
const _coldThresholdC = 10.0;
const _hotWaterBumpMl = 200;

/// An extra watering tip for today's weather, layered on top of the
/// roadmap's baseline [baseWaterMl] guidance. Returns null when the
/// weather isn't notable enough to warrant overriding the baseline tip.
@riverpod
WeatherTip? weatherTip(Ref ref, int baseWaterMl) {
  final weather = ref.watch(weatherCacheProvider).value;
  if (weather == null) return null;

  switch (weather.condition) {
    case WeatherCondition.rain:
    case WeatherCondition.drizzle:
    case WeatherCondition.thunderstorm:
    case WeatherCondition.snow:
      return const WeatherTip(WeatherTipKind.wetOutside);
    case WeatherCondition.clear:
    case WeatherCondition.cloudy:
    case WeatherCondition.fog:
      if (weather.temperatureC >= _hotThresholdC) {
        return WeatherTip(
          WeatherTipKind.hot,
          suggestedWaterMl: baseWaterMl + _hotWaterBumpMl,
        );
      }
      if (weather.temperatureC <= _coldThresholdC) {
        return const WeatherTip(WeatherTipKind.cold);
      }
      return null;
  }
}
