// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_todo_bloc.dart';

abstract class FilteredTodoEvent extends Equatable {
  const FilteredTodoEvent();

  @override
  List<Object> get props => [];
}

class PerformFilteringEvent extends FilteredTodoEvent {
  final List<Todo> todoListBloc;
  final Filter todoFilterBloc;
  final String todoSearchBloc;
  PerformFilteringEvent({
    required this.todoListBloc,
    required this.todoFilterBloc,
    required this.todoSearchBloc,
  });

  @override
  List<Object> get props => [todoFilterBloc, todoListBloc, todoSearchBloc];

  @override
  String toString() =>
      'PerformFilteringEvent(todoListBloc: $todoListBloc, todoFilterBloc: $todoFilterBloc, todoSearchBloc: $todoSearchBloc)';
}
