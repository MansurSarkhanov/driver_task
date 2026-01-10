import 'package:driver_task/features/tasks/domain/task_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/task_list_states.dart';

class TaskListCubit extends Cubit<TaskListStates> {
  final TaskDomain repository;
  TaskListCubit({required this.repository}) : super(TaskListInitial());

  Future<void> fetchTaskList() async {
    emit(TaskListLoading());
    final result = await repository.getTaskList();
    result.fold(
      (tasks) => emit(TaskListSuccess(tasks: tasks)),
      (error) => emit(TaskListError(message: error)),
    );
  }
}
