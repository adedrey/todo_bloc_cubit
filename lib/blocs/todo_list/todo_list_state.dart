// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() => TodoListState(
        todos: [
          Todo(desc: "Clean your room", id: "1"),
          Todo(desc: "Wash your clothes", id: "2"),
          Todo(desc: "Build Apps", id: "3"),
        ],
      );

  @override
  String toString() => 'TodoListState(todos: $todos)';

  @override
  List<Object> get props => [todos];

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}
