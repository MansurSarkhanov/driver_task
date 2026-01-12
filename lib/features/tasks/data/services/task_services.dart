import 'package:driver_task/core/config/dio_client.dart';
import 'package:driver_task/core/config/request_executor.dart';
import 'package:driver_task/env/api_enviroment.dart';
import 'package:driver_task/features/tasks/data/models/task_detail_response.dart';

import '../../../../core/utils/enums/http_method_enum.dart';
import '../../../../shared/models/api_result.dart';
import '../models/task_list_model.dart';

abstract class ITaskServices {
  Future<ApiResult<TaskResponse>> getTaskList();
  Future<ApiResult<TaskDetailResponse>> getTaskDetail(String id);
}

final class TaskServices extends RequestExecutor implements ITaskServices {
  TaskServices() : super(DioClient.instance.dio);
  @override
  Future<ApiResult<TaskResponse>> getTaskList() {
    return executeRequest(
      url: ApiEnviroment.current.tasksList,
      parser: (json) => TaskResponse.fromJson(json),
      method: HttpMethodEnum.GET,
    );
  }

  @override
  Future<ApiResult<TaskDetailResponse>> getTaskDetail(String id) {
    return executeRequest(
      url: "${ApiEnviroment.current.tasksList}/$id",
      parser: (json) => TaskDetailResponse.fromJson(json),
      method: HttpMethodEnum.GET,
    );
  }
}
