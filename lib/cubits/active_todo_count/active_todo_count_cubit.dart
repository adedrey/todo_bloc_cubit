import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_bloc/models/todo_model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final TodoListCubit todoListCubit;
  final int initialActiveTodoCount;
  late final StreamSubscription todoListSubscription;
  ActiveTodoCountCubit({
    required this.todoListCubit,
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      print('todoListState: ${todoListState}');
      final int currentActiveTodoCount = todoListState.todos
          .where(
            (Todo t) => !t.completed,
          )
          .length;
      emit(
        state.copyWith(activeTodoCount: currentActiveTodoCount),
      );
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    todoListSubscription.cancel();
    return super.close();
  }
}
