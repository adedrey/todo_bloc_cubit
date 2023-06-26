import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(TodoSearchState.initial()) {
    on<SearchTaskEvent>(
      (event, emit) {
        emit(state.copyWith(searchedWord: event.searchedWord));
      },
      transformer: debounce(
        Duration(
          milliseconds: 1000,
        ),
      ),
    );
  }

  EventTransformer<SearchTaskEvent> debounce<SearchTaskEvent>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
