class Task {
  int? id;
  final String taskTitle;
  final String category;
  final String date;
  final String description;
  final String status;

  Task({
    required this.id,
    required this.taskTitle,
    required this.category,
    required this.date,
    required this.description,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      taskTitle: json['taskTitle'] as String,
      category: json['category'] as String,
      date: json['date'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskTitle': taskTitle,
      'category': category,
      'date': date,
      'description': description,
      'status': status,
    };
  }

}
