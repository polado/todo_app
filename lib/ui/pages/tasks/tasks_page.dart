import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category_model.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/ui/widgets/task_widget.dart';

import 'add_edit_task/add_edit_task_page.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends BaseState<TasksPage> {
  List<TaskModel> tasks = new List();

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(AppCache()
              .getFirebaseUser()
              .uid)
              .collection('tasks')
              .orderBy('time', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              tasks = snapshot.data.documents
                  .map((t) => TaskModel.firebase(t))
                  .toList();
              return ListView(
                padding: EdgeInsets.only(bottom: 96),
                children: tasks
                    .map((t) =>
                    TaskWidget(
                      task: t,
                      callback: (CategoryModel category) =>
                          navigateTo(
                              AddEditTaskPage(
                                  task: t, category: category, isEdit: true)),
                      onDismiss: (direction) {
                        print('dismiss $direction');
                      },
                    ))
                    .toList(),
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

  _signOut() async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
  }
}
