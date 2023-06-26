import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';
import '../todo_list/todo_list_bloc.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  final TodoListBloc todoListBloc;
  final int initialActiveTodoCount;
  late final StreamSubscription todoListSubscription;
  ActiveTodoCountBloc({
    required this.todoListBloc,
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      print('todoListState: ${todoListState}');
      final int currentActiveTodoCount = todoListState.todos
          .where(
            (Todo t) => !t.completed,
          )
          .length;
      add(IncrementActiveTodo(activeTodoCount: currentActiveTodoCount));
    });

    on<IncrementActiveTodo>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    todoListSubscription.cancel();
    return super.close();
  }
}
