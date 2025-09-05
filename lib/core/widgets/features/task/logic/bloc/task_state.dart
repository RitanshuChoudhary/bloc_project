import 'package:equatable/equatable.dart';

import '../../data/task_model.dart';

class TaskState extends Equatable {
  final List<Task> tasks;
  const TaskState({this.tasks = const <Task>[]});

  @override
  List<Object?> get props => [tasks];

  TaskState copyWith({List<Task>? tasks}) {
    return TaskState(tasks: tasks ?? this.tasks);
  }
}
