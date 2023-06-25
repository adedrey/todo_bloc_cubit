// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/cubits/todo_filter/todo_filter_cubit.dart';

import 'package:todo_bloc/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_bloc/cubits/todo_search/todo_search_cubit.dart';

import '../../models/todo_model.dart';

part 'filtered_todo_state.dart';

class FilteredTodoCubit extends Cubit<FilteredTodoState> {
  late final StreamSubscription todoListCubitStreamSubscription;
  late final StreamSubscription filteredTodoCubitStreamSubscription;
  late final StreamSubscription todoSearchCubitStreamSubscription;
  final TodoListCubit todoListCubit;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final List<Todo> initialTodos;
  FilteredTodoCubit({
    required this.todoListCubit,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.initialTodos,
  }) : super(FilteredTodoState(filteredTodoList: initialTodos)) {
    todoListCubitStreamSubscription = todoListCubit.stream
        .listen((TodoListState todoListState) => _setFilteredTodos());
    filteredTodoCubitStreamSubscription = todoFilterCubit.stream
        .listen((TodoFilterState todoFilterState) => _setFilteredTodos());
    todoSearchCubitStreamSubscription = todoSearchCubit.stream
        .listen((TodoSearchState todoSearchState) => _setFilteredTodos());
  }

  void _setFilteredTodos() {
    List<Todo> _filteredTodoLists;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filteredTodoLists = todoListCubit.state.todos
            .where((Todo todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        _filteredTodoLists = todoListCubit.state.todos
            .where((Todo todo) => todo.completed)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodoLists = todoListCubit.state.todos;
        break;
    }

    if (todoSearchCubit.state.searchedWord.isNotEmpty) {
      _filteredTodoLists = _filteredTodoLists
          .where(
            (Todo todo) => todo.desc.toLowerCase().contains(
                  todoSearchCubit.state.searchedWord.toLowerCase(),
                ),
          )
          .toList();
    }
    emit(state.copyWith(filteredTodoList: _filteredTodoLists));
  }

  @override
  Future<void> close() {
    // TODO: implement close
    todoListCubitStreamSubscription.cancel();
    todoSearchCubitStreamSubscription.cancel();
    filteredTodoCubitStreamSubscription.cancel();
    return super.close();
  }
}
