import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/todo_model.dart';

import 'package:todo_bloc/blocs/todo_filter/todo_filter_bloc.dart';

import 'package:todo_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_bloc/blocs/todo_search/todo_search_bloc.dart';
part 'filtered_todo_event.dart';
part 'filtered_todo_state.dart';

class FilteredTodoBloc extends Bloc<FilteredTodoEvent, FilteredTodoState> {
  final List<Todo> initialTodos;
  FilteredTodoBloc({
    required this.initialTodos,
  }) : super(FilteredTodoState(filteredTodoList: initialTodos)) {
    on<PerformFilteringEvent>(_performFilteringEvent);
  }

  void _performFilteringEvent(
      PerformFilteringEvent event, Emitter<FilteredTodoState> emit) {
    List<Todo> _filteredTodoLists;

    switch (event.todoFilterBloc) {
      case Filter.active:
        _filteredTodoLists =
            event.todoListBloc.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodoLists =
            event.todoListBloc.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodoLists = event.todoListBloc;
        break;
    }

    if (event.todoSearchBloc.isNotEmpty) {
      _filteredTodoLists = _filteredTodoLists
          .where(
            (Todo todo) => todo.desc.toLowerCase().contains(
                  event.todoSearchBloc.toLowerCase(),
                ),
          )
          .toList();
    }
    emit(state.copyWith(filteredTodoList: _filteredTodoLists));
  }
}
