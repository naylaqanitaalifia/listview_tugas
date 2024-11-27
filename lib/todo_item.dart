import 'package:flutter/material.dart';
import 'task_model.dart';

class TodoItem extends StatelessWidget {
  final Task task;
  final Function(Task) onToggleCompletion;
  final Function(Task) onEdit;
  final Function(Task) onDelete;

  TodoItem({
    required this.task,
    required this.onToggleCompletion,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggleCompletion(task),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            fontSize: 16,
          ),
        ),
        subtitle: Text(task.time),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => onEdit(task),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDelete(task),
            ),
          ],
        ),
      ),
    );
  }
}
