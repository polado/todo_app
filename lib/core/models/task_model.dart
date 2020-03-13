import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/models/category_model.dart';

class TaskModel {
  String id;
  bool isDone = false;
  String title;
  String description;
  Timestamp addedDate;
  Timestamp dueDate;
  CategoryModel category;

  TaskModel(
      {this.title,
      this.description,
      this.isDone,
      this.addedDate,
        this.dueDate,
        this.category});

  TaskModel.firebase(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.title = snapshot['title'];
    this.description = snapshot['description'];
    this.isDone = snapshot['is_done'];
    this.dueDate = snapshot['due_date'];
    if (snapshot['category'] != null)
      this.category = new CategoryModel(
          snapshot['category']['name'], Color(snapshot['category']['color']));
    else
      this.category = new CategoryModel("name", Colors.white);
  }
}
