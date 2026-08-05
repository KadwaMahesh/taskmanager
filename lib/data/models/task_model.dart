class TaskItem {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TaskItem({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      completed: json["completed"],
    );
  }
}
