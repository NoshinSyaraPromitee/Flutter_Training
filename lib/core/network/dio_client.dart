import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Single shared Dio instance for the whole app, pointed at the Go backend.
class DioClient {
  DioClient._();

  static const int _port = 8081;

  /// Where the Go backend is reachable from the *current* platform. This
  /// differs per target, which is a common source of "works on Chrome,
  /// fails on the emulator" confusion:
  ///
  /// - Web / desktop / iOS simulator: plain loopback works, since they
  ///   share the host's network stack.
  /// - Android emulator: `localhost` means the emulator itself, not your
  ///   machine. `10.0.2.2` is the emulator's alias for the host loopback.
  /// - Physical device: neither works. Replace this with your machine's LAN
  ///   address (e.g. `http://192.168.1.x:8080`) and keep both on the same
  ///   Wi-Fi.
  ///
  /// This belongs in an `--dart-define` / env config once the backend is
  /// deployed somewhere; hardcoding localhost is a local-development
  /// shortcut, not the end state.
  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:$_port';
    }
    return 'http://localhost:$_port';
  }

  static final Dio instance = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      // Generous, because this is what the AI call has to fit inside. The
      // current backend provider is a mock and answers instantly, but a
      // real Gemini/Groq round trip on a photo can take many seconds.
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );
}
