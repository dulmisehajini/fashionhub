import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';

class ApiService {
  late Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));

    // ── Request Interceptor ──────────────────
    // Automatically adds JWT token to every request
    // Like axios interceptors you know from React!
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'jwt_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  // ── AUTH ─────────────────────────────────────

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );
      // Save token securely
      await _storage.write(
        key: 'jwt_token',
        value: response.data['token'],
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      // Save token securely
      await _storage.write(
        key: 'jwt_token',
        value: response.data['token'],
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'jwt_token');
    return token != null;
  }

  // ── PRODUCTS ──────────────────────────────────

  Future<List<dynamic>> getProducts({String? category}) async {
    try {
      final response = await _dio.get(
        ApiConstants.products,
        queryParameters: category != null && category != 'All'
            ? {'category': category}
            : null,
      );
      return response.data['products'];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── ERROR HANDLER ─────────────────────────────
  String _handleError(DioException e) {
    if (e.response != null) {
      return e.response?.data['message'] ?? 'Something went wrong';
    }
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout — is the server running?';
    }
    return 'Network error — check your connection';
  }
}