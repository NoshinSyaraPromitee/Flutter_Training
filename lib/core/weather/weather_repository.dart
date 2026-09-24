import 'weather.dart';

abstract class WeatherRepository {
  Future<Weather> current({required double lat, required double lon});
}
