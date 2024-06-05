import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final remianingTodoProvider = StateProvider<int>((ref) {
//   final todos = ref.watch(todoControllerProvider).todos;
//   var remainingTodos = todos.where((element) => element.isCompleted).toList();
//   return remainingTodos.length;
// });

// final allTodoProvider = StateProvider<TodoState>((ref) {
//   final todos = ref.watch(todoControllerProvider).todos;
//   return TodoState.initial().copyWith(todos: todos);
// });

// final pinnedTodoProvider = StateProvider<TodoState>((ref) {
//   final todos = ref.watch(todoControllerProvider).todos;
//   var pinnedTodos = todos.where((element) => element.isPinned).toList();
//   return TodoState.initial().copyWith(todos: pinnedTodos);
// });

// final activeTodoProvider = StateProvider<TodoState>((ref) {
//   final todos = ref.watch(todoControllerProvider).todos;
//   var activeTodos = todos.where((element) => !element.isCompleted).toList();
//   return TodoState.initial().copyWith(todos: activeTodos);
// });

// final completedTodoProvider = StateProvider<TodoState>((ref) {
//   final todos = ref.watch(todoControllerProvider).todos;
//   var completedTodos = todos.where((element) => element.isCompleted).toList();
//   return TodoState.initial().copyWith(todos: completedTodos);
// });

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 40),
          const HeaderWidget(),
          const SizedBox(height: 40),
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
                    const TopRow(),
                    const Header(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: 'What do you want to do?',
                          border: OutlineInputBorder(),
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
    );
  }
}

//header widget

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'Manage your \n',
        style: TextStyle(fontSize: 30, color: Colors.black),
        children: [
          TextSpan(
            text: 'Todos',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' in your elegant \n',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          TextSpan(
            text: 'Todopad',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// class CommonTodo extends ConsumerWidget {
//   const CommonTodo(this.todoProvider, {super.key});

//   final StateProvider todoProvider;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final todos = ref.watch(todoProvider);
//     return ListView.separated(
//       separatorBuilder: (context, index) => const SizedBox(height: 10),
//       itemCount: todos.todos.length,
//       itemBuilder: (context, index) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.grey,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           height: 70,
//           child: InkWell(
//             onTap: () {
//               ref
//                   .read(todoControllerProvider.notifier)
//                   .updateTodo(todos.todos[index]);
//             },
//             child: ListTile(
//               leading: Radio(
//                 value: todos.todos[index].isCompleted,
//                 groupValue: true,
//                 onChanged: (value) {},
//               ),
//               title: Text(todos.todos[index].title),
//               trailing: IconButton(
//                 onPressed: () {
//                   ref
//                       .read(todoControllerProvider.notifier)
//                       .updatePinned(todos.todos[index]);
//                 },
//                 icon: Icon(Icons.star,
//                     color: todos.todos[index].isPinned
//                         ? Colors.yellow
//                         : Colors.white),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: RichText(
          text: const TextSpan(
            text: 'My',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: ' Todopad',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({
    super.key,
  });

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
