import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/location_service.dart';

part 'location_providers.g.dart';

/// The device's current coordinates, resolved once per app session
/// (re-requesting GPS on every read would be wasteful and re-prompt
/// permissions unnecessarily).
@Riverpod(keepAlive: true)
Future<(double lat, double lon)> currentPosition(Ref ref) {
  return const LocationService().current();
}
