import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String name;
  final String status;
  final Timestamp createdAt;

  Task({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'status': status, 'createdAt': createdAt};
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      createdAt: map['createdAt'],
    );
  }
}
