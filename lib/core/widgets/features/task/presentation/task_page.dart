import 'package:bloctodolist/core/widgets/features/auth/data/models/user_model.dart';
import 'package:bloctodolist/core/widgets/features/task/data/task_model.dart';
import 'package:bloctodolist/core/widgets/features/task/logic/bloc/task_bloc.dart';
import 'package:bloctodolist/core/widgets/features/task/logic/bloc/task_event.dart';
import 'package:bloctodolist/core/widgets/features/task/logic/bloc/task_state.dart';
import 'package:bloctodolist/core/widgets/features/task/presentation/tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskPage extends StatelessWidget {
  final UserModel user;
  TaskPage({super.key, required this.user});

  final workNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  void _showTaskDialog(BuildContext context, {Task? task}) {
    final isEditing = task != null;
    if (isEditing) {
      workNameController.text = task.workName;
      descriptionController.text = task.description;
      dateController.text = task.date;
    } else {
      workNameController.clear();
      descriptionController.clear();
      dateController.clear();
    }

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            isEditing ? "Edit Task" : "Add Task",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputField("Work Name", workNameController, Icons.work),
                const SizedBox(height: 12),
                _buildInputField(
                  "Description",
                  descriptionController,
                  Icons.notes,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.date_range),
                    labelText: "Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    final pickedDate = await showDatePicker(
                      initialDate: DateTime.now(),
                      context: context,
                      firstDate: DateTime.utc(2002),
                      lastDate: DateTime.utc(2030),
                    );
                    if (pickedDate != null) {
                      dateController.text = pickedDate
                          .toIso8601String()
                          .split("T")
                          .first;
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final newTask = Task(
                  id: isEditing
                      ? task!.id
                      : DateTime.now().millisecondsSinceEpoch.toString(),
                  description: descriptionController.text,
                  workName: workNameController.text,
                  date: dateController.text,
                );
                if (isEditing) {
                  context.read<TaskBloc>().add(UpdateTask(task: newTask));
                } else {
                  context.read<TaskBloc>().add(AddTasks(task: newTask));
                }
                Navigator.pop(context);
              },
              child: Text(isEditing ? "Update" : "Add"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => _showTaskDialog(context),
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
      appBar: AppBar(
        title: Text(
          "Todo List",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(30),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.network(
                      "https://randomuser.me/api/portraits/men/33.jpg",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  user.userName,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return Center(
              child: Text(
                "No Tasks Yet!",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: state.tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return TaskTile(
                task: task,
                onEdit: () => _showTaskDialog(context, task: task),
                onDelete: () =>
                    context.read<TaskBloc>().add(DeleteTask(id: task.id)),
              );
            },
          );
        },
      ),
    );
  }
}
