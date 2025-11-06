import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';
import 'task_list_screen.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskIdController = TextEditingController();
  final TextEditingController _taskNameController = TextEditingController();
  String _status = 'open';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addTask() async {
    String id = _taskIdController.text.trim();
    final String name = _taskNameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task name')),
      );
      return;
    }

    if (id.isEmpty) {
      //Generate a new ID if none is provided
      id = const Uuid().v4();
    } else {
      //Check if the ID is already in use
      final existingTask =
      await _firestore.collection('tasks').doc(id).get();
      if (existingTask.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This Task ID already exists! Please use another one.')),
        );
        return;
      }
    }

    final Task task = Task(id: id, name: name, status: _status);
    await _firestore.collection('tasks').doc(id).set(task.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task added successfully (ID: $id)')),
    );

    _taskIdController.clear();
    _taskNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _taskIdController,
              decoration: const InputDecoration(
                labelText: 'Task ID (optional)',
                border: OutlineInputBorder(),
                hintText: 'Leave empty to auto-generate an ID',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _taskNameController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _status,
              items: const [
                DropdownMenuItem(value: 'open', child: Text('Open')),
                DropdownMenuItem(value: 'closed', child: Text('Closed')),
              ],
              onChanged: (value) => setState(() => _status = value!),
              decoration: const InputDecoration(
                labelText: 'Task Status',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add Task'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TaskListScreen()),
              ),
              child: const Text('Go to Task List'),
            ),
          ],
        ),
      ),
    );
  }
}
