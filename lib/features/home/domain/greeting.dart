enum GreetingKind {
  morning,
  afternoon,
  evening,
  night,
  plantThirsty,
  weatherRain,
  weatherThunderstorm,
  weatherSnow,
  weatherFog,
  weatherHot,
}

/// What the mascot's speech bubble should say. [temperatureC] is only set
/// for [GreetingKind.weatherHot], which needs it as a message placeholder.
class Greeting {
  const Greeting(this.kind, {this.temperatureC});

  final GreetingKind kind;
  final int? temperatureC;
}
