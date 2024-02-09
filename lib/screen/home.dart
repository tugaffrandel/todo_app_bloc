import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/data/todo.dart';
import 'package:todo_app_bloc/widget/add_todo.dart';
import 'package:todo_app_bloc/widget/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  addTodo() {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Title is Empty')));
    } else if (subtitleController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Description is Empty')));
    } else {
      context.read<TodoBloc>().add(
            AddTodo(
              Todo(
                title: titleController.text,
                subtitle: subtitleController.text,
              ),
            ),
          );
      titleController.clear();
      subtitleController.clear();
      Navigator.pop(context);
    }
  }

  removeTodo(Todo todo) {
    context.read<TodoBloc>().add(RemoveTodo(todo));
  }

  updateTodo(int index) {
    context.read<TodoBloc>().add(UpdateTodo(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddTodoDialog(
                  titleController: titleController,
                  subtitleController: subtitleController,
                  saveTodo: addTodo,
                );
              });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(
          'Todo App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state.status == TodoStatus.success) {
              return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, int i) {
                    return TodoTile(
                      title: state.todos[i].title,
                      subtitle: state.todos[i].subtitle,
                      value: state.todos[i].isDone,
                      removeTodo: (_) => removeTodo(state.todos[i]),
                      onChanged: (_) => updateTodo(i),
                    );
                  });
            } else if (state.status == TodoStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
