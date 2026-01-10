import 'package:driver_task/env/api_endpoints.dart';
import 'package:driver_task/env/dev/dev_api_endpoints.dart';
import 'package:driver_task/env/enviroment.dart';
import 'package:driver_task/env/prod/prod_api_endpoints.dart';

class ApiEnviroment {
  static final ApiEndpoints _devEndpoints = DevApiEndpoints();
  static final ApiEndpoints _prodEndpoints = ProdApiEndpoints();

  static ApiEndpoints get current {
    if (Environment().isProd) {
      return _prodEndpoints;
    } else {
      return _devEndpoints;
    }
  }
}
