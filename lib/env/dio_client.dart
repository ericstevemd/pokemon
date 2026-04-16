import 'package:dio/dio.dart';
import 'package:pokemon/env/app_config.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static Dio? _instance;

  // ✅ 3️⃣ Agrega este getter 'instance' (patrón Singleton)
  static Dio get instance {
    if (_instance == null) {
      _instance = Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
          connectTimeout: Duration(seconds: AppConfig.connectTimeout),
          // ⚠️ 4️⃣ Corrige este nombre: receivestimeout → receiveTimeout (camelCase)
          receiveTimeout: Duration(seconds: AppConfig.receivestimeout),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      // 🎁 5️⃣ (Opcional) Agrega interceptors solo al crear la instancia
      if (kDebugMode) {
        _instance!.interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true, error: true),
        );
      }
    }
    return _instance!;
  }

  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: Duration(seconds: AppConfig.connectTimeout),
        receiveTimeout: Duration(seconds: AppConfig.receivestimeout),
        headers: {'Accept': 'application/json'},
      ),
    );
  }
}
