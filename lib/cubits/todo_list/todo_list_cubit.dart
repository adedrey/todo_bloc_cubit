import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo({required String todoDesc}) {
    emit(
      state.copyWith(
        todos: [
          ...state.todos,
          Todo(
            desc: todoDesc,
          ),
        ],
      ),
    );
  }

  void editTodo({required String todoDesc, required String id}) {
    final newTodos = state.todos.map(
      (todo) {
        if (todo.id == id) {
          return Todo(
            desc: todoDesc,
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

  void toggleTodo({required String id}) {
    final newTodos = state.todos.map(
      (todo) {
        if (todo.id == id) {
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

  void removeTodo({required String id}) {
    final newTodos = state.todos.where((Todo t) => t.id != id).toList();
    emit(
      state.copyWith(
        todos: newTodos,
      ),
    );
  }
}
