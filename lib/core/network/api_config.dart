import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Resolves the MyPlantPal backend's base URL for the current platform.
///
/// The Go API (see /backend) runs on localhost:8080 by default. Android
/// emulators can't reach the host machine via `localhost`, so they use the
/// special `10.0.2.2` alias instead; every other platform uses `localhost`.
///
/// Note: this deliberately uses `defaultTargetPlatform` rather than
/// `dart:io`'s `Platform`. Importing `dart:io` is a compile error on the
/// web target, which would break `flutter run -d chrome` for the whole app
/// — not just for the features that use this class.
class ApiConfig {
  ApiConfig._();

  static const String _port = '8081';

  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:$_port';
    }
    return 'http://localhost:$_port';
  }
}
