import 'package:bloctodolist/core/widgets/features/task/data/task_model.dart';
import 'package:bloctodolist/core/widgets/features/task/logic/bloc/task_event.dart';
import 'package:bloctodolist/core/widgets/features/task/logic/bloc/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTasks>((event, emit) {
      final updatedTasks = List<Task>.from(state.tasks)..add(event.task);
      emit(state.copyWith(tasks: updatedTasks));
    });
    on<UpdateTask>((event, emit) {
      final updatedTasks = state.tasks.map((task) {
        return task.id == event.task.id ? event.task : task;
      }).toList();
      emit(state.copyWith(tasks: updatedTasks));
    });

    on<DeleteTask>((event, emit) {
      final updatedTasks = state.tasks
          .where((task) => task.id != event.id)
          .toList();
      emit(state.copyWith(tasks: updatedTasks));
    });
  }
}
