import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [
    Task(
      title: 'Midsem Exam Preparation',
      courseCode: 'INFT 425',
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    Task(
      title: 'Database Design Project',
      courseCode: 'INFT 421',
      dueDate: DateTime.now().add(const Duration(days: 5)),
    ),
    Task(
      title: 'Mobile App Logic',
      courseCode: 'INFT 425',
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isComplete ? TextDecoration.lineThrough : null,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.courseCode),
                  Text(
                    DateFormat('dd/MM/yyyy').format(task.dueDate),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: Checkbox(
                value: task.isComplete,
                onChanged: (value) {
                  setState(() {
                    task.isComplete = value ?? false;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
