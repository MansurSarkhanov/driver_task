import 'package:driver_task/features/tasks/presentation/bloc/state/task_detail_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/task_domain.dart';

class TaskDetailCubit extends Cubit<TaskDetailStates> {
  final TaskDomain repository;
  TaskDetailCubit({required this.repository}) : super(TaskDetailInitial());

  Future<void> fetchTaskDetail(String id) async {
    emit(TaskDetailLoading());
    final result = await repository.getTaskDetail(id);
    result.fold(
      (taskDetail) => emit(TaskDetailSuccess(taskDetail: taskDetail)),
      (error) => emit(TaskDetailError(message: error)),
    );
  }
}
