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

  List<String> get parsedErrorMessages {
    if (error is Map<String, dynamic> && error.containsKey('error')) {
      final raw = error['error'] as String;
      return raw
          .split(RegExp(r'[\n;]'))
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return [];
  }

  List<String> get parsedErrorMessages2 {
    if (error is Map<String, dynamic> && error.containsKey('message')) {
      final raw = error['message'] as String;
      return raw
          .split(RegExp(r'[\n;]'))
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return [];
  }

  List<String> get parsedErrorsMessages {
    if (error is Map<String, dynamic> && error.containsKey('errors')) {
      final raw = error['errors'];
      if (raw is List) {
        return raw
            .map((e) => e.toString().trim())
            .where((e) => e.isNotEmpty)
            .toList();
      } else if (raw is String) {
        return raw
            .split(RegExp(r'[\n;]'))
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
    }
    return [];
  }
}
