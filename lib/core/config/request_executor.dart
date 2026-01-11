import 'package:dio/dio.dart';

import '../../shared/models/api_result.dart';
import '../utils/enums/http_method_enum.dart';
import '../utils/exceptions/custom_exception.dart';

class RequestExecutor {
  final Dio dio;
  const RequestExecutor(this.dio);

  Future<ApiResult<T>> executeRequest<T>({
    required String url,
    required T Function(Map<String, dynamic> json) parser,
    Object? data,
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    String? contentType,
    ResponseType? responseType,
    required HttpMethodEnum method,
  }) async {
    try {
      late Response response;
      final Options options = Options(
        responseType: responseType ?? ResponseType.json,
        contentType: (data is FormData)
            ? null
            : (contentType ?? Headers.jsonContentType),
        headers: headers,
      );
      switch (method) {
        case HttpMethodEnum.GET:
          response = await dio.get(
            url,
            data: data,
            queryParameters: query,
            cancelToken: cancelToken,
            options: options,
          );
          break;
        case HttpMethodEnum.POST:
          response = await dio.post(
            url,
            data: data,
            queryParameters: query,
            cancelToken: cancelToken,
            options: options,
          );
          break;
        case HttpMethodEnum.PUT:
          response = await dio.put(
            url,
            data: data,
            queryParameters: query,
            cancelToken: cancelToken,
            options: options,
          );
          break;
        case HttpMethodEnum.PATCH:
          response = await dio.patch(
            url,
            data: data,
            queryParameters: query,
            cancelToken: cancelToken,
            options: options,
          );
          break;
        case HttpMethodEnum.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: query,
            cancelToken: cancelToken,
            options: options,
          );
      }
      final int status = response.statusCode ?? 0;
      final body = response.data;
      if (status == 204) {
        return ApiResult.success(data: true as T);
      }

      if (responseType == ResponseType.bytes) {
        return ApiResult.success(data: body);
      }
      final model = parser(body);
      return ApiResult.success(data: model);
    } on DioException catch (e) {
      return ApiResult.failure(
        error: e.response?.data ?? {'error': 'Unknown error'},
        statusCode: e.response?.statusCode,
      );
    } catch (e, s) {
      throw CustomException('An error occurred: $e$s');
    }
  }
}
