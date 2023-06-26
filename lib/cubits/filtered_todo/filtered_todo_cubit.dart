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
  final List<Todo> initialTodos;
  FilteredTodoCubit({
    required this.initialTodos,
  }) : super(FilteredTodoState(filteredTodoList: initialTodos));

  void setFilteredTodos(
      {required List<Todo> currentTodoList,
      required Filter currentFilter,
      required String currentSearchedWords}) {
    List<Todo> _filteredTodoLists;

    switch (currentFilter) {
      case Filter.active:
        _filteredTodoLists =
            currentTodoList.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodoLists =
            currentTodoList.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodoLists = currentTodoList;
        break;
    }

    if (currentSearchedWords.isNotEmpty) {
      _filteredTodoLists = _filteredTodoLists
          .where(
            (Todo todo) => todo.desc.toLowerCase().contains(
                  currentSearchedWords.toLowerCase(),
                ),
          )
          .toList();
    }
    emit(state.copyWith(filteredTodoList: _filteredTodoLists));
  }
}
