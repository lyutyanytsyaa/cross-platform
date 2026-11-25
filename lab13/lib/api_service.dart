import 'package:dio/dio.dart';

/// Сервіс для надсилання даних форм на сервер через пакет dio.
class ApiService {
  // Субдомен на requestcatcher.com, куди надсилаються запити
  static const baseUrl = 'https://lab13anital.requestcatcher.com';

  // Один екземпляр Dio для всього застосунку
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  /// Вхід: POST https://lab13anital.requestcatcher.com/login
  static Future<Response> login({
    required String email,
    required String password,
  }) {
    return _dio.post('/login', data: {
      'email': email,
      'password': password,
    });
  }

  /// Реєстрація: POST https://lab13anital.requestcatcher.com/signup
  static Future<Response> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return _dio.post('/signup', data: {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  /// Скидання пароля: POST https://lab13anital.requestcatcher.com/reset
  static Future<Response> resetPassword({required String email}) {
    return _dio.post('/reset', data: {
      'email': email,
    });
  }
}