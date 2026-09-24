import 'package:flutter/foundation.dart';

class AppConfig {
  AppConfig._();
  // 10.0.2.2 is the Android-emulator-only alias for the host machine's localhost;
  // real devices / iOS simulator need a different host value (e.g. your machine's LAN IP).
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: kIsWeb ? 'http://localhost:8081' : 'http://10.0.2.2:8081',
  );
  static const googleClientId = String.fromEnvironment('GOOGLE_CLIENT_ID',
      defaultValue: '951483915022-b7ape69mbclro6jlhnjrm7650qmftcuk.apps.googleusercontent.com');
  static const googleRedirectUri = String.fromEnvironment('GOOGLE_REDIRECT_URI',
      defaultValue: 'https://sixfold-document-bucktooth.ngrok-free.dev/auth/google/callback');
  static const appCallbackScheme = 'plantpal';
  static const appCallbackUri = 'plantpal://auth';
}