import 'package:equatable/equatable.dart';

import '../../data/task_model.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTasks extends TaskEvent {
  final Task task;
  AddTasks({required this.task});
  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask({required this.task});
  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String id;
  DeleteTask({required this.id});
  @override
  List<Object?> get props => [id];
}
