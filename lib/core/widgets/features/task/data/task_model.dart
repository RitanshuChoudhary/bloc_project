class Task {
  final String id;
  final String workName;
  final String description;
  final String date;

  Task({
    required this.id,
    required this.description,
    required this.workName,
    required this.date,
  });

  Task copyWith({
    String? id,
    String? workName,
    String? description,
    String? date,
  }) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      workName: workName ?? this.workName,
      date: date ?? this.date,
    );
  }
}
