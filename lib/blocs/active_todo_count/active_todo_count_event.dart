// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'active_todo_count_bloc.dart';

abstract class ActiveTodoCountEvent extends Equatable {
  const ActiveTodoCountEvent();

  @override
  List<Object> get props => [];
}

class IncrementActiveTodo extends ActiveTodoCountEvent {
  final int activeTodoCount;
  IncrementActiveTodo({
    required this.activeTodoCount,
  });

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() => 'IncrementActiveTodo(activeTodoCount: $activeTodoCount)';
}
