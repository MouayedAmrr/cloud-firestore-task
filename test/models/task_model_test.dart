import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_task2/models/task_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Task model', () {
    test('toMap returns correct map', () {
      final timestamp = Timestamp.now();
      final task = Task(
        id: '123',
        name: 'Test Task',
        status: 'pending',
        createdAt: timestamp,
      );

      final map = task.toMap();

      expect(map['id'], '123');
      expect(map['name'], 'Test Task');
      expect(map['status'], 'pending');
      expect(map['createdAt'], timestamp);
    });

    test('fromMap returns correct Task object', () {
      final timestamp = Timestamp.now();
      final map = {
        'id': '456',
        'name': 'Another Task',
        'status': 'done',
        'createdAt': timestamp,
      };

      final task = Task.fromMap(map);

      expect(task.id, '456');
      expect(task.name, 'Another Task');
      expect(task.status, 'done');
      expect(task.createdAt, timestamp);
    });
  });
}
