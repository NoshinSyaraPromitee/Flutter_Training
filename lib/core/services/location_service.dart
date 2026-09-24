import 'package:geolocator/geolocator.dart';

/// Falls back to Dhaka, Bangladesh when location is unavailable or denied.
const fallbackLatitude = 23.8103;
const fallbackLongitude = 90.4125;

/// Thin wrapper around device geolocation, with a graceful fallback so
/// callers never have to handle permission errors themselves.
class LocationService {
  const LocationService();

  Future<(double lat, double lon)> current() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return (fallbackLatitude, fallbackLongitude);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return (fallbackLatitude, fallbackLongitude);
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );
      return (position.latitude, position.longitude);
    } catch (_) {
      return (fallbackLatitude, fallbackLongitude);
    }
  }
}
