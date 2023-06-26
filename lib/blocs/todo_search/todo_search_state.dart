// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_search_bloc.dart';

class TodoSearchState extends Equatable {
  final String searchedWord;
  TodoSearchState({
    required this.searchedWord,
  });

  factory TodoSearchState.initial() => TodoSearchState(searchedWord: '');

  @override
  String toString() => 'TodoSearchState(searchedWord: $searchedWord)';

  @override
  List<Object> get props => [searchedWord];

  TodoSearchState copyWith({
    String? searchedWord,
  }) {
    return TodoSearchState(
      searchedWord: searchedWord ?? this.searchedWord,
    );
  }
}
