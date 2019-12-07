import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  bool isDone = false;
  String title;
  String description;
  Timestamp addedDate;
  Timestamp dueDate;

  Task(
      {this.title,
      this.description,
      this.isDone,
      this.addedDate,
      this.dueDate});

  Task.edit({this.id,
    this.title,
    this.description,
    this.isDone,
    this.addedDate,
    this.dueDate});

  Task.firebase(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.title = snapshot['title'];
    this.description = snapshot['description'];
    this.isDone = snapshot['is_done'];
    this.dueDate = snapshot['due_date'];
  }
}
