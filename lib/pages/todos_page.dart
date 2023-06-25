import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/pages/create_todo.dart';
import 'package:todo_bloc/pages/search_todo.dart';
import 'package:todo_bloc/pages/show_todos.dart';

import '../cubits/cubits.dart';
import 'todo_header.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TodoHeader(),
              CreateTodo(),
              SearchTodo(),
              Expanded(
                child: ShowTodos(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
