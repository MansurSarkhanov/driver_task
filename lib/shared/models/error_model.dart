import 'package:equatable/equatable.dart';

class ApiErrorResponse extends Equatable {
  final ApiError error;

  const ApiErrorResponse({required this.error});

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(error: ApiError.fromJson(json['error']));
  }

  @override
  List<Object?> get props => [error];
}

class ApiError extends Equatable {
  final String name;
  final String message;
  final String header;

  const ApiError({
    required this.name,
    required this.message,
    required this.header,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      name: json['name'],
      message: json['message'],
      header: json['header'],
    );
  }

  @override
  List<Object?> get props => [name, message, header];
}
