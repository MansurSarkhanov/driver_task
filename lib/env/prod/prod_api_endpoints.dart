import '../../core/extensions/api_extension.dart';
import '../api_endpoints.dart';

final class ProdApiEndpoints implements ApiEndpoints {
  @override
  String get tasksList => '/tasks'.connectToService();

  @override
  String get taskDetail => '/tasks'.connectToService();

  @override
  String taskStart(String id) => '/tasks/$id/scan'.connectToService();
}
