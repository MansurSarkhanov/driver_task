import 'package:dio/dio.dart' as request;

final class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final request.Dio _dio;
  factory DioClient() => _instance;
  DioClient._internal() {
    _dio = _createSecureDio();
  }

  request.Dio _createSecureDio() {
    final dio = request.Dio(
      request.BaseOptions(
        connectTimeout: const Duration(milliseconds: 300000),
        receiveTimeout: const Duration(milliseconds: 300000),
      ),
    );
    dio.interceptors.add(
      request.LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
      ),
    );

    return dio;
  }

  request.Dio get dio => _dio;
}
