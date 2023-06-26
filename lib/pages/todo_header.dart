import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../models/todo_model.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "TODO",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            final int currentActiveTodoCount = state.todos
                .where(
                  (Todo t) => !t.completed,
                )
                .length;
            context.read<ActiveTodoCountBloc>().add(
                IncrementActiveTodo(activeTodoCount: currentActiveTodoCount));
          },
          child: Text(
            "${context.watch<ActiveTodoCountBloc>().state.activeTodoCount} items left",
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
