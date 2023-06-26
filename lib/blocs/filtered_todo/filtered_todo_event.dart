// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_todo_bloc.dart';

abstract class FilteredTodoEvent extends Equatable {
  const FilteredTodoEvent();

  @override
  List<Object> get props => [];
}

class PerformFilteringEvent extends FilteredTodoEvent {
  final List<Todo> filteredList;
  PerformFilteringEvent({
    required this.filteredList,
  });

  @override
  List<Object> get props => [filteredList];

  @override
  String toString() => 'PerformFilteringEvent(filteredList: $filteredList)';
}
