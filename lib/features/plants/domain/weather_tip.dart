enum WeatherTipKind { hot, cold, wetOutside }

/// An extra, weather-driven watering tip shown alongside the roadmap's
/// baseline tips. [suggestedWaterMl] is only set for [WeatherTipKind.hot].
class WeatherTip {
  const WeatherTip(this.kind, {this.suggestedWaterMl});

  final WeatherTipKind kind;
  final int? suggestedWaterMl;
}
