import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/models/task.dart';

class Category {
  String id;
  String name;
  String color;
  List<Task> tasks = new List();

  Category({this.color, this.name, this.tasks});

  Category.firebase(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.color = snapshot['color'];
    this.name = snapshot['name'];
  }

  setTasks(QuerySnapshot snapshot) {
    snapshot.documents.forEach((s) {
      Task task = new Task.firebase(s);
      tasks.add(task);
    });
  }
}
