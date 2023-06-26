import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_bloc/models/todo_model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final int initialActiveTodoCount;
  ActiveTodoCountCubit({
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount));

  void modifyActiveTodoCount({required List<Todo> currentTodos}) {
    final int currentActiveTodoCount = currentTodos
        .where(
          (Todo t) => !t.completed,
        )
        .length;

    emit(state.copyWith(activeTodoCount: currentActiveTodoCount));
  }
}
