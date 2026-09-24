/// Broad weather categories, mapped from Open Meteo's WMO weather codes
/// (see https://open-meteo.com/en/docs — "WMO Weather interpretation codes").
enum WeatherCondition { clear, cloudy, fog, drizzle, rain, snow, thunderstorm }

WeatherCondition weatherConditionFromCode(int code) {
  if (code == 0) return WeatherCondition.clear;
  if (code <= 3) return WeatherCondition.cloudy;
  if (code <= 48) return WeatherCondition.fog;
  if (code <= 57) return WeatherCondition.drizzle;
  if (code <= 67 || (code >= 80 && code <= 82)) return WeatherCondition.rain;
  if (code <= 77 || (code >= 85 && code <= 86)) return WeatherCondition.snow;
  return WeatherCondition.thunderstorm;
}

class Weather {
  const Weather({
    required this.temperatureC,
    required this.condition,
    required this.isDay,
    required this.fetchedAt,
  });

  final double temperatureC;
  final WeatherCondition condition;
  final bool isDay;
  final DateTime fetchedAt;
}
