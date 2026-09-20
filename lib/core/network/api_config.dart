import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

/// Resolves the MyPlantPal backend's base URL for the current platform.
///
/// The Go API (see /backend) runs on localhost:8080 by default. Android
/// emulators can't reach the host machine via `localhost`, so they use the
/// special `10.0.2.2` alias instead; every other platform uses `localhost`.
class ApiConfig {
  ApiConfig._();

  static const String _port = '8080';

  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:$_port';
    if (Platform.isAndroid) return 'http://10.0.2.2:$_port';
    return 'http://localhost:$_port';
  }
}
