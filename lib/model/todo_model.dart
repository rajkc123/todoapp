class Todo {
  final String title;
  final bool isCompleted;
  final bool isPinned;

  Todo({
    required this.title,
    this.isCompleted = false,
    this.isPinned = false,
  });

  Todo copyWith({
    String? title,
    bool? isCompleted,
    bool? isPinned,
  }) {
    return Todo(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
