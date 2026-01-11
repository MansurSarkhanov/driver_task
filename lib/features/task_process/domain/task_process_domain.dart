import 'package:either_dart/either.dart';

abstract class TaskProcessDomain {
  Future<Either<bool, String>> scanTasks(String id);
  Future<Either<bool, String>> failTask(String id);
  Future<Either<bool, String>> startTask(String id);
}
