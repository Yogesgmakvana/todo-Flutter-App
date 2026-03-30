class Todo {
  String title;
  String date;
  bool isDone;

  Todo({
    required this.title,
    required this.date,
    this.isDone = false,
  });

  // Convert to Map (for SharedPreferences)
  Map<String, dynamic> toJson() => {
        'title': title,
        'date': date,
        'isDone': isDone,
      };

  // Convert from Map
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json['title'],
        date: json['date'],
        isDone: json['isDone'],
      );
}