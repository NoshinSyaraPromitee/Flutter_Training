class AppConfig {
  AppConfig._();
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:5000');
  static const googleClientId = String.fromEnvironment('GOOGLE_CLIENT_ID',
      defaultValue: '951483915022-b7ape69mbclro6jlhnjrm7650qmftcuk.apps.googleusercontent.com');
  static const googleRedirectUri = String.fromEnvironment('GOOGLE_REDIRECT_URI',
      defaultValue: 'https://sixfold-document-bucktooth.ngrok-free.dev/auth/google/callback');
  static const appCallbackScheme = 'plantpal';
  static const appCallbackUri = 'plantpal://auth';
}