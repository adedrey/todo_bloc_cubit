import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/cubits/cubits.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final todo =
            context.watch<FilteredTodoCubit>().state.filteredTodoList[index];
        return Dismissible(
          onDismissed: (direction) {
            context.read<TodoListCubit>().removeTodo(id: todo.id);
          },
          key: ValueKey(todo.id),
          child: ListTile(
            leading: Checkbox(
              value: todo.completed,
              onChanged: (value) {
                context.read<TodoListCubit>().toggleTodo(id: todo.id);
              },
            ),
            title: Text(todo.desc),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemCount:
          context.watch<FilteredTodoCubit>().state.filteredTodoList.length,
    );
  }
}
