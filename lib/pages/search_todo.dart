import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todo_bloc/cubits/cubits.dart';

import '../blocs/todo_search/todo_search_bloc.dart';
import '../models/todo_model.dart';
import '../utils/debounce.dart';

class SearchTodo extends StatefulWidget {
  const SearchTodo({super.key});

  @override
  State<SearchTodo> createState() => _SearchTodoState();
}

class _SearchTodoState extends State<SearchTodo> {
  final TextEditingController todoController = TextEditingController();
  final Debounce debounce = Debounce();

  @override
  void dispose() {
    // TODO: implement dispose
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: todoController,
            decoration: InputDecoration(
              labelText: "Search",
              border: InputBorder.none,
              filled: true,
              prefix: Icon(Icons.search),
            ),
            onChanged: (String? todoDesc) {
              if (todoDesc != null) {
                debounce.run(
                  () => context
                      .read<TodoSearchBloc>()
                      .add(SearchTaskEvent(searchedWord: todoController.text)),
                );
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _filteredTab(filter: Filter.all),
              _filteredTab(filter: Filter.active),
              _filteredTab(filter: Filter.completed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _filteredTab({required Filter filter}) {
    return TextButton(
      onPressed: () {
        context.read<TodoFilterBloc>().add(ChangeFilterEvent(filter: filter));
      },
      child: Text(
        filter == Filter.all
            ? "All"
            : filter == Filter.active
                ? 'Active'
                : 'Completed',
        style: TextStyle(
          color: _colorFiltered(filter: filter),
          fontSize: 18,
        ),
      ),
    );
  }

  Color _colorFiltered({required Filter filter}) {
    return context.watch<TodoFilterBloc>().state.filter == filter
        ? Colors.blue
        : Colors.black;
  }
}
