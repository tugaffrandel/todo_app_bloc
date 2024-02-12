import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Function(BuildContext) removeTodo;
  final Function(bool?) onChanged;
  const TodoTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.removeTodo,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: removeTodo,
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Checkbox(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
