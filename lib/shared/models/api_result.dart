import 'error_model.dart';

class ApiResult<T> {
  final T? data;
  final dynamic error;
  final int? statusCode;
  final bool isSuccess;

  ApiResult._({
    this.data,
    this.error,
    this.statusCode,
    required this.isSuccess,
  });

  factory ApiResult.success({required T data}) {
    return ApiResult._(data: data, isSuccess: true);
  }

  factory ApiResult.failure({required dynamic error, int? statusCode}) {
    return ApiResult._(error: error, statusCode: statusCode, isSuccess: false);
  }

  ApiErrorResponse toErrorResponse() {
    return ApiErrorResponse.fromJson(error);
  }
}
