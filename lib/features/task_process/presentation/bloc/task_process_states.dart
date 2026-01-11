abstract class TaskProcessStates {}

class TaskProcessInitial extends TaskProcessStates {}

class TaskProcessLoading extends TaskProcessStates {}

class TaskProcessSuccess extends TaskProcessStates {
  final String message;
  TaskProcessSuccess({required this.message});
}

class TaskProcessError extends TaskProcessStates {
  final String message;
  TaskProcessError({required this.message});
}
