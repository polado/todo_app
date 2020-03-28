import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/models/task_model.dart';

class CategoryModel {
  String id;
  String name;
  Color color;
  List<TaskModel> tasks = new List();

  CategoryModel(this.name, this.color);

  CategoryModel.firebase(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.color = Color(snapshot['color']);
    this.name = snapshot['name'];
  }

  static List<CategoryModel> fromList(QuerySnapshot snapshot) {
    List<CategoryModel> categories = new List();
    snapshot.documents.forEach((d) {
      categories.add(new CategoryModel.firebase(d));
    });

    return categories;
  }

  static int getIndex(List<CategoryModel> list, CategoryModel model) {
    int index = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == model.id) index = i;
    }
    return index;
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
