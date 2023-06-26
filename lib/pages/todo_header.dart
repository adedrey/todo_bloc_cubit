import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubits.dart';

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
        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) {
            context.read<ActiveTodoCountCubit>().modifyActiveTodoCount(
                  currentTodos: state.todos,
                );
          },
          child: Text(
            "${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} items left",
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
