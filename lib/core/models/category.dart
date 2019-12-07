import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/models/task.dart';

class Category {
  String id;
  String name;
  String color;
  List<Task> tasks = new List();
  List<Task> doneTasks = new List();

  Category({this.color, this.name, this.tasks});

  Category.firebase(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.color = snapshot['color'];
    this.name = snapshot['name'];
    this.tasks = new List();
  }

  setAllTasks(QuerySnapshot snapshot) {
    doneTasks.clear();
    tasks.clear();
    snapshot.documents.forEach((s) {
      Task task = new Task.firebase(s);
      if (task.isDone)
        doneTasks.add(task);
      else
        tasks.add(task);
    });
  }

  setTasks(QuerySnapshot snapshot) {
    snapshot.documents.forEach((s) {
      Task task = new Task.firebase(s);
      tasks.add(task);
    });
  }

  setDoneTasks(QuerySnapshot snapshot) {
    snapshot.documents.forEach((s) {
      Task task = new Task.firebase(s);
      doneTasks.add(task);
    });
  }
}
