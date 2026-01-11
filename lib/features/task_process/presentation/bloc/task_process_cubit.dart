import 'package:driver_task/features/task_process/domain/task_process_domain.dart';
import 'package:driver_task/features/task_process/presentation/bloc/task_process_states.dart';
import 'package:driver_task/features/tasks/data/models/task_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/routes.dart';

class TaskProcessCubit extends Cubit<TaskProcessStates> {
  TaskProcessCubit({required this.repository}) : super(TaskProcessInitial());
  final TaskProcessDomain repository;

  Future<void> startTask({
    required String id,
    required BuildContext context,
  }) async {
    emit(TaskProcessLoading());
    final result = await repository.startTask(id);
    result.fold(
      (success) => emit(TaskProcessSuccess(isLoading: false)),
      (error) => emit(TaskProcessError(message: error)),
    );
  }

  Future<void> failTask({
    required String id,
    required BuildContext context,
  }) async {
    final result = await repository.failTask(id);
    result.fold(
      (success) => context.pop(),
      (error) => emit(TaskProcessError(message: error)),
    );
  }

  Future<void> scanTasks({
    required String id,
    required BuildContext context,
    required TaskDetailModel taskDetailModel,
  }) async {
    emit(TaskProcessSuccess(isLoading: true));
    final result = await repository.scanTasks(id);
    result.fold((success) {
      emit(TaskProcessSuccess(isLoading: false));
      context.push(Routes.scanPackages, extra: taskDetailModel);
    }, (error) => emit(TaskProcessError(message: error)));
  }
}
