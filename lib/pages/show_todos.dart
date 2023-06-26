import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/cubits/cubits.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) =>
              context.read<FilteredTodoCubit>().setFilteredTodos(
                    currentTodoList: state.todos,
                    currentFilter: context.read<TodoFilterCubit>().state.filter,
                    currentSearchedWords:
                        context.read<TodoSearchCubit>().state.searchedWord,
                  ),
        ),
        BlocListener<TodoFilterCubit, TodoFilterState>(
          listener: (context, state) =>
              context.read<FilteredTodoCubit>().setFilteredTodos(
                    currentTodoList: context.read<TodoListCubit>().state.todos,
                    currentFilter: state.filter,
                    currentSearchedWords:
                        context.read<TodoSearchCubit>().state.searchedWord,
                  ),
        ),
        BlocListener<TodoSearchCubit, TodoSearchState>(
          listener: (context, state) =>
              context.read<FilteredTodoCubit>().setFilteredTodos(
                    currentTodoList: context.read<TodoListCubit>().state.todos,
                    currentFilter: context.read<TodoFilterCubit>().state.filter,
                    currentSearchedWords: state.searchedWord,
                  ),
        ),
      ],
      child: ListView.separated(
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
      ),
    );
  }
}
