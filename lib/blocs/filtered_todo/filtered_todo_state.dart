// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'filtered_todo_bloc.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> filteredTodoList;
  FilteredTodoState({
    required this.filteredTodoList,
  });

  factory FilteredTodoState.initial() =>
      FilteredTodoState(filteredTodoList: []);

  @override
  String toString() => 'FilteredTodoState(filteredTodoList: $filteredTodoList)';

  FilteredTodoState copyWith({
    List<Todo>? filteredTodoList,
  }) {
    return FilteredTodoState(
      filteredTodoList: filteredTodoList ?? this.filteredTodoList,
    );
  }

  @override
  List<Object> get props => [filteredTodoList];
}
