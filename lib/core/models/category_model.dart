import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/models/task_model.dart';

class CategoryModel {
  String id;
  String name;
  Color color;
  List<TaskModel> tasks = new List();

  CategoryModel(this.name, this.color);

  CategoryModel.firebase(Map<String, dynamic> snapshot) {
    this.color = Color(snapshot['color']);
    this.name = snapshot['name'];
  }

  setTasks(QuerySnapshot snapshot) {
    snapshot.documents.forEach((s) {
      TaskModel task = new TaskModel.firebase(s);
      tasks.add(task);
    });
  }

  Map toJson() {
    return {"name": name, "color": color.value};
  }
}
