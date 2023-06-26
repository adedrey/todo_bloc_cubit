import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTaskEvent>(_addTaskEvent);
    on<EditTaskEvent>(_editTaskEvent);
    on<ToggleTaskEvent>(_toggleTaskEvent);
    on<RemoveTaskEvent>(_removeTaskEvent);
  }

  void _addTaskEvent(AddTaskEvent event, Emitter<TodoListState> emit) {
    emit(
      state.copyWith(
        todos: [
          ...state.todos,
          Todo(
            desc: event.desc,
          ),
        ],
      ),
    );
  }

  void _editTaskEvent(EditTaskEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map(
      (todo) {
        if (todo.id == event.id) {
          return Todo(
            desc: event.desc,
            id: todo.id,
            completed: todo.completed,
          );
        }
        return todo;
      },
    ).toList();
    emit(
      state.copyWith(
        todos: newTodos,
      ),
    );
  }

  void _toggleTaskEvent(ToggleTaskEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map(
      (todo) {
        if (todo.id == event.id) {
          return Todo(
            desc: todo.desc,
            id: todo.id,
            completed: todo.completed ? false : true,
          );
        }
        return todo;
      },
    ).toList();
    emit(
      state.copyWith(
        todos: newTodos,
      ),
    );
  }

  void _removeTaskEvent(RemoveTaskEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.where((Todo t) => t.id != event.id).toList();
    emit(
      state.copyWith(
        todos: newTodos,
      ),
    );
  }
}
