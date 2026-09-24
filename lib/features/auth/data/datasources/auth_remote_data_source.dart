import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/network/api_client.dart';

class AuthTokens {
  const AuthTokens({required this.accessToken, required this.refreshToken, required this.userJson});
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic> userJson;
}

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._api);
  final ApiClient _api;

  Future<AuthTokens> register({required String email, required String password, String? name}) async {
    final res = await _api.dio.post('/api/v1/auth/register', data: {
      'email': email,
      'password': password,
      if (name != null && name.isNotEmpty) 'name': name,
    });
    return _toTokens(res.data as Map<String, dynamic>);
  }

  Future<AuthTokens> login({required String email, required String password}) async {
    final res = await _api.dio.post('/api/v1/auth/login', data: {'email': email, 'password': password});
    return _toTokens(res.data as Map<String, dynamic>);
  }

  Future<void> logout(String refreshToken) async {
    await _api.dio.post('/api/v1/auth/logout', data: {'refreshToken': refreshToken});
  }

  AuthTokens _toTokens(Map<String, dynamic> json) => AuthTokens(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
        userJson: json['user'] as Map<String, dynamic>,
      );

  /// Google OAuth round-trip. Returns the app JWT, or null if cancelled.
  Future<String?> googleLogin() async {
    const redirect = AppConfig.appCallbackUri;
    final url = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
      'client_id': AppConfig.googleClientId,
      'redirect_uri': AppConfig.googleRedirectUri,
      'response_type': 'code',
      'scope': 'openid email profile',
      'state': redirect,
    });
    try {
      await FlutterWebAuth2.authenticate(url: url.toString(), callbackUrlScheme: AppConfig.appCallbackScheme);
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') return null;
      rethrow;
    }
    final res = await _api.dio.get('/auth/google/session/${Uri.encodeComponent(redirect)}');
    return (res.data as Map<String, dynamic>)['token'] as String?;
  }
}