import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  final String title;
  final bool isCompleted;
  final bool isPinned;

  Todo({
    required this.title,
    this.isCompleted = false,
    this.isPinned = false,
  });
}

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void updateTodoStatus(Todo todo, bool isCompleted) {
    state = [
      for (final t in state)
        if (t == todo)
          Todo(
            title: t.title,
            isCompleted: isCompleted,
            isPinned: t.isPinned,
          )
        else
          t,
    ];
  }

  void updatePinned(Todo todo) {
    state = [
      for (final t in state)
        if (t == todo)
          Todo(
            title: t.title,
            isCompleted: t.isCompleted,
            isPinned: !t.isPinned,
          )
        else
          t,
    ];
  }
}

final todoControllerProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

enum TodoFilter { all, active, favourite, done }

final todoFilterProvider = StateProvider<TodoFilter>((ref) => TodoFilter.all);

final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todoControllerProvider);

  switch (filter) {
    case TodoFilter.active:
      return todos.where((todo) => !todo.isCompleted).toList();
    case TodoFilter.favourite:
      return todos.where((todo) => todo.isPinned).toList();
    case TodoFilter.done:
      return todos.where((todo) => todo.isCompleted).toList();
    case TodoFilter.all:
    default:
      return todos;
  }
});
