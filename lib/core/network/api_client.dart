import 'package:dio/dio.dart';

/// Centralized network client for remote API communication.
class ApiClient {
  static final Dio instance = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_URL', defaultValue: 'http://localhost:3000/v1'), // Localhost backend API URL
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ))
    ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
}
