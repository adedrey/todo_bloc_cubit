// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TodoListEvent {
  final String desc;
  AddTaskEvent({
    required this.desc,
  });

  @override
  String toString() => 'AddTaskEvent(desc: $desc)';

  @override
  List<Object> get props => [desc];
}

class EditTaskEvent extends TodoListEvent {
  final String id;
  final String desc;
  EditTaskEvent({
    required this.id,
    required this.desc,
  });

  @override
  String toString() => 'EditTaskEvent(id: $id, desc: $desc)';

  @override
  List<Object> get props => [id, desc];
}

class RemoveTaskEvent extends TodoListEvent {
  final String id;
  RemoveTaskEvent({
    required this.id,
  });

  @override
  String toString() => 'RemoveTaskEvent(id: $id)';

  @override
  List<Object> get props => [id];
}

class ToggleTaskEvent extends TodoListEvent {
  final String id;
  ToggleTaskEvent({
    required this.id,
  });

  @override
  String toString() => 'ToggleTaskEvent(id: $id)';

  @override
  List<Object> get props => [id];
}
