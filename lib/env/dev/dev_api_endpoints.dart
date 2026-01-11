import 'package:driver_task/core/extensions/api_extension.dart';

import '../api_endpoints.dart';

final class DevApiEndpoints implements ApiEndpoints {
  @override
  String get tasksList => '/tasks'.connectToService();

  @override
  String get taskDetail => '/tasks'.connectToService();

  @override
  String taskStart(String id) => '/tasks/$id/scan'.connectToService();

  @override
  String failTask(String id) => '/tasks/$id/failed'.connectToService();

  @override
  String scanTask(String id) => '/tasks/$id/scan'.connectToService();
}
