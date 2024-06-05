import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/todo_controller.dart';
import '../model/todo_model.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(filteredTodosProvider);
    final isLoading = ref.watch(todoControllerProvider).isEmpty;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final completedCount = todos.where((todo) => todo.isCompleted).length;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Manage your\nTodos in your elegant\nTodopad',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SearchBar(),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '$completedCount of ${todos.length} tasks completed',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const HeaderWidget(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TabBar(
                            controller: _tabController,
                            tabs: const [
                              Tab(text: 'All'),
                              Tab(text: 'Active'),
                              Tab(text: 'Favourite'),
                              Tab(text: 'Done'),
                            ],
                            onTap: (index) {
                              ref.read(todoFilterProvider.notifier).state =
                                  TodoFilter.values[index];
                            },
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: List.generate(
                              4,
                              (index) => TodoList(todos: todos),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class TodoList extends ConsumerWidget {
  final List<Todo> todos;

  const TodoList({super.key, required this.todos});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Radio(
              value: todo.isCompleted,
              groupValue: true,
              onChanged: (value) {
                ref
                    .read(todoControllerProvider.notifier)
                    .updateTodoStatus(todo, !todo.isCompleted);
              },
            ),
            title: Text(todo.title),
            trailing: IconButton(
              onPressed: () {
                ref.read(todoControllerProvider.notifier).updatePinned(todo);
              },
              icon: Icon(Icons.star,
                  color: todo.isPinned ? Colors.yellow : Colors.white),
            ),
          ),
        );
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'What do you want to do?',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RichText(
          text: const TextSpan(
            text: 'My',
            style: TextStyle(color: Colors.black, fontSize: 30),
            children: [
              TextSpan(
                text: ' Todopad',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RichText(
          text: const TextSpan(
            text: 'My',
            style: TextStyle(color: Colors.black, fontSize: 30),
            children: [
              TextSpan(
                text: ' Todopad',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.web),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.web_asset),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ],
    );
  }
}
