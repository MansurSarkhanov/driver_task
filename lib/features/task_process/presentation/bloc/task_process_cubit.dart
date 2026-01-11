import 'package:driver_task/features/task_process/domain/task_process_domain.dart';
import 'package:driver_task/features/task_process/presentation/bloc/task_process_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_helper.dart';
import '../../../../shared/dialogs/error_dialog.dart';

class TaskProcessCubit extends Cubit<TaskProcessStates> {
  TaskProcessCubit({required this.repository}) : super(TaskProcessInitial());
  final TaskProcessDomain repository;

  Future<bool?> startTask({
    required String id,
    required BuildContext context,
  }) async {
    final result = await repository.startTask(id);
    if (result.isLeft) {
      return true;
    } else {
      AppHelper.showAnimationDialog(
        child: ErrorDialog(message: result.right),
        context: context,
      );
    }
    return null;
  }

  Future<void> failTask(String id) async {
    emit(TaskProcessLoading());
    final result = await repository.failTask(id);
    result.fold(
      (success) =>
          emit(TaskProcessSuccess(message: 'Task failed successfully')),
      (error) => emit(TaskProcessError(message: error)),
    );
  }

  Future<void> scanTasks(String id) async {
    emit(TaskProcessLoading());
    final result = await repository.scanTasks(id);
    result.fold(
      (success) =>
          emit(TaskProcessSuccess(message: 'Task scanned successfully')),
      (error) => emit(TaskProcessError(message: error)),
    );
  }
}
