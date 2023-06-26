// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_search_bloc.dart';

abstract class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTaskEvent extends TodoSearchEvent {
  final String searchedWord;
  SearchTaskEvent({
    required this.searchedWord,
  });

  @override
  List<Object> get props => [searchedWord];

  SearchTaskEvent copyWith({
    String? searchedWord,
  }) {
    return SearchTaskEvent(
      searchedWord: searchedWord ?? this.searchedWord,
    );
  }

  @override
  String toString() => 'SearchTaskEvent(searchedWord: $searchedWord)';
}
