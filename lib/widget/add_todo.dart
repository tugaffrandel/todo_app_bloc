import 'package:flutter/material.dart';

class AddTodoDialog extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final void Function() saveTodo;

  const AddTodoDialog(
      {super.key,
      required this.titleController,
      required this.subtitleController,
      required this.saveTodo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            cursorColor: Theme.of(context).colorScheme.secondary,
            decoration: InputDecoration(
                hintText: 'Task Title...',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey))),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: subtitleController,
            cursorColor: Theme.of(context).colorScheme.secondary,
            decoration: InputDecoration(
                hintText: 'Task Description...',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey))),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: saveTodo,
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Center(
                child: Text(
              'Save Todo',
              style: TextStyle(color: Colors.black),
            )),
          ),
        )
      ],
    );
  }
}
