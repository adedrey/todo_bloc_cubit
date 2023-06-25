import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/cubits/cubits.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final TextEditingController todoController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    todoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: todoController,
        decoration: InputDecoration(
          labelText: "What to do",
        ),
        onSubmitted: (String? todoDesc) {
          if (todoDesc != null && todoController.text.isNotEmpty) {
            context
                .read<TodoListCubit>()
                .addTodo(todoDesc: todoController.text);
            todoController.clear();
          }
        },
      ),
    );
  }
}
