import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_search_state.dart';

class TodoSearchCubit extends Cubit<TodoSearchState> {
  TodoSearchCubit() : super(TodoSearchState.initial());

  void searchItem({required String searchKey}) {
    emit(
      state.copyWith(searchedWord: searchKey),
    );
  }
}
