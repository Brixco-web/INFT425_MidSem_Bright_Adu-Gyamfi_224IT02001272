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

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final courseController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: courseController,
                decoration: const InputDecoration(labelText: 'Course Code'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    selectedDate == null
                        ? 'No Date Chosen'
                        : DateFormat('dd/MM/yyyy').format(selectedDate!),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setDialogState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Choose Date'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    courseController.text.isNotEmpty &&
                    selectedDate != null) {
                  setState(() {
                    _tasks.add(Task(
                      title: titleController.text,
                      courseCode: courseController.text,
                      dueDate: selectedDate!,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text('No tasks yet!'))
          : ListView.builder(
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
