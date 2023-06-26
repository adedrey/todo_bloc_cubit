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
  late final StreamSubscription todoListBlocStreamSubscription;
  late final StreamSubscription filteredTodoBlocStreamSubscription;
  late final StreamSubscription todoSearchBlocStreamSubscription;
  final TodoListBloc todoListBloc;
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;
  final List<Todo> initialTodos;
  FilteredTodoBloc({
    required this.todoListBloc,
    required this.todoFilterBloc,
    required this.todoSearchBloc,
    required this.initialTodos,
  }) : super(FilteredTodoState(filteredTodoList: initialTodos)) {
    todoListBlocStreamSubscription = todoListBloc.stream
        .listen((TodoListState todoListState) => setFilteredTodos());
    filteredTodoBlocStreamSubscription = todoFilterBloc.stream
        .listen((TodoFilterState todoFilterState) => setFilteredTodos());
    todoSearchBlocStreamSubscription = todoSearchBloc.stream
        .listen((TodoSearchState todoSearchState) => setFilteredTodos());
    on<PerformFilteringEvent>((event, emit) {
      emit(state.copyWith(filteredTodoList: event.filteredList));
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodoLists;

    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        _filteredTodoLists = todoListBloc.state.todos
            .where((Todo todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        _filteredTodoLists = todoListBloc.state.todos
            .where((Todo todo) => todo.completed)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodoLists = todoListBloc.state.todos;
        break;
    }

    if (todoSearchBloc.state.searchedWord.isNotEmpty) {
      _filteredTodoLists = _filteredTodoLists
          .where(
            (Todo todo) => todo.desc.toLowerCase().contains(
                  todoSearchBloc.state.searchedWord.toLowerCase(),
                ),
          )
          .toList();
    }
    add(PerformFilteringEvent(filteredList: _filteredTodoLists));
  }

  @override
  Future<void> close() {
    // TODO: implement close
    todoListBlocStreamSubscription.cancel();
    todoSearchBlocStreamSubscription.cancel();
    filteredTodoBlocStreamSubscription.cancel();
    return super.close();
  }
}
