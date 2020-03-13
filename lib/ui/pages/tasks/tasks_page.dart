import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/ui/task_widget.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends BaseState<TasksPage> {
  List<TaskModel> tasks = new List();

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(AppCache.instance.getUser().uid)
              .collection('tasks')
              .orderBy('time', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              tasks = snapshot.data.documents
                  .map((t) => TaskModel.firebase(t))
                  .toList();
              return Column(
                children: tasks.map((t) => TaskWidget(task: t)).toList(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("errror"),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
