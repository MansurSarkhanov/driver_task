import 'package:driver_task/core/config/dio_client.dart';
import 'package:driver_task/core/config/request_executor.dart';
import 'package:driver_task/core/utils/enums/http_method_enum.dart';
import 'package:driver_task/env/api_enviroment.dart';
import 'package:driver_task/shared/models/api_result.dart';

abstract class ITaskProcessService {
  Future<ApiResult<bool>> scanTasks(String id);
  Future<ApiResult<bool>> failTask(String id);
  Future<ApiResult<bool>> startTask(String id);
}

final class TaskProcessService extends RequestExecutor
    implements ITaskProcessService {
  TaskProcessService() : super(DioClient.instance.dio);

  @override
  Future<ApiResult<bool>> startTask(String id) {
    return executeRequest(
      url: ApiEnviroment.current.taskStart(id),
      parser: (json) => true,
      method: HttpMethodEnum.PATCH,
    );
  }

  @override
  Future<ApiResult<bool>> failTask(String id) {
    return executeRequest(
      url: ApiEnviroment.current.failTask(id),
      parser: (json) => true,
      method: HttpMethodEnum.PATCH,
    );
  }

  @override
  Future<ApiResult<bool>> scanTasks(String id) {
    return executeRequest(
      url: ApiEnviroment.current.scanTask(id),
      parser: (json) => true,
      method: HttpMethodEnum.PATCH,
    );
  }
}
