abstract class TaskProcessStates {}

class TaskProcessInitial extends TaskProcessStates {}

class TaskProcessLoading extends TaskProcessStates {}

class TaskProcessSuccess extends TaskProcessStates {
  final bool isLoading;
  TaskProcessSuccess({required this.isLoading});
}

class TaskProcessError extends TaskProcessStates {
  final String message;
  TaskProcessError({required this.message});
}
