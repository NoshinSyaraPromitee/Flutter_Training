import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/weather_providers.dart';
import '../../../../core/weather/weather.dart';
import '../../domain/greeting.dart';

part 'greeting_providers.g.dart';

/// What the mascot's speech bubble should say.
@riverpod
Greeting greetingMessage(Ref ref) {
  final weather = ref.watch(weatherCacheProvider).value;

  if (weather != null) {
    final weatherGreeting = _weatherGreeting(weather);
    if (weatherGreeting != null) return weatherGreeting;
  }

  return Greeting(_timeGreetingKind(DateTime.now().hour));
}

Greeting? _weatherGreeting(Weather weather) {
  switch (weather.condition) {
    case WeatherCondition.thunderstorm:
      return const Greeting(GreetingKind.weatherThunderstorm);
    case WeatherCondition.rain:
    case WeatherCondition.drizzle:
      return const Greeting(GreetingKind.weatherRain);
    case WeatherCondition.snow:
      return const Greeting(GreetingKind.weatherSnow);
    case WeatherCondition.fog:
      return const Greeting(GreetingKind.weatherFog);
    case WeatherCondition.clear:
    case WeatherCondition.cloudy:
      if (weather.temperatureC >= 35) {
        return Greeting(
          GreetingKind.weatherHot,
          temperatureC: weather.temperatureC.round(),
        );
      }
      return null;
  }
}

GreetingKind _timeGreetingKind(int hour) {
  if (hour < 5) return GreetingKind.night;
  if (hour < 12) return GreetingKind.morning;
  if (hour < 17) return GreetingKind.afternoon;
  if (hour < 21) return GreetingKind.evening;
  return GreetingKind.night;
}