import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            context.read<FilteredTodoBloc>().add(
                  PerformFilteringEvent(
                    todoListBloc: state.todos,
                    todoFilterBloc: context.read<TodoFilterBloc>().state.filter,
                    todoSearchBloc:
                        context.read<TodoSearchBloc>().state.searchedWord,
                  ),
                );
          },
        ),
        BlocListener<TodoFilterBloc, TodoFilterState>(
          listener: (context, state) {
            context.read<FilteredTodoBloc>().add(
                  PerformFilteringEvent(
                    todoListBloc: context.read<TodoListBloc>().state.todos,
                    todoFilterBloc: state.filter,
                    todoSearchBloc:
                        context.read<TodoSearchBloc>().state.searchedWord,
                  ),
                );
          },
        ),
        BlocListener<TodoSearchBloc, TodoSearchState>(
          listener: (context, state) {
            context.read<FilteredTodoBloc>().add(
                  PerformFilteringEvent(
                    todoListBloc: context.read<TodoListBloc>().state.todos,
                    todoFilterBloc: context.read<TodoFilterBloc>().state.filter,
                    todoSearchBloc: state.searchedWord,
                  ),
                );
          },
        ),
      ],
      child: ListView.separated(
        itemBuilder: (context, index) {
          final todo =
              context.watch<FilteredTodoBloc>().state.filteredTodoList[index];
          return Dismissible(
            onDismissed: (direction) {
              context.read<TodoListBloc>().add(RemoveTaskEvent(id: todo.id));
            },
            key: ValueKey(todo.id),
            child: ListTile(
              leading: Checkbox(
                value: todo.completed,
                onChanged: (value) {
                  context
                      .read<TodoListBloc>()
                      .add(ToggleTaskEvent(id: todo.id));
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
            context.watch<FilteredTodoBloc>().state.filteredTodoList.length,
      ),
    );
  }
}
