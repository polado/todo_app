import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/blocs/category_bloc.dart';
import 'package:todo_app/core/blocs/task_bloc.dart';
import 'package:todo_app/core/models/category.dart';
import 'package:todo_app/core/models/task.dart';
import 'package:todo_app/ui/add_task_page.dart';
import 'package:todo_app/ui/task_widget.dart';

class CategoryWidget extends StatefulWidget {
  final Category category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  SolidController solidController = new SolidController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 0,
      color: MyColors.getColor(widget.category.color),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          AppBar(
            elevation: 0,
            backgroundColor: MyColors.getColor(widget.category.color),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(
              '${widget.category.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.color_lens),
                onPressed: () {
                  if (solidController.isOpened)
                    solidController.hide();
                  else
                    solidController.show();
                },
              ),
              IconButton(
                icon: Icon(Icons.playlist_add),
                onPressed: () => addNewTaskPage(),
              ),
            ],
          ),
          body(),
        ],
      ),
    );
  }

  buildTasksList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document(AppCache.firebaseUser.uid)
          .collection('categories')
          .document(widget.category.id)
          .collection('tasks')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        print("gettasks ${snapshot.hasData}");
        if (snapshot.hasData) {
          widget.category.setTasks(snapshot.data);
          return widget.category.tasks.length == 0
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "No Tasks Added",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(bottom: 4),
                  itemCount: snapshot.data.documents.length,
                  physics: new NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TaskWidget(
                      category: widget.category,
                      task: new Task.firebase(snapshot.data.documents[index]),
                    );
                  },
                );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  addNewTaskPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new AddTaskPage(
        category: widget.category,
      );
    }));
  }

  addNewTaskDialog() {
    TextEditingController textEditingController = new TextEditingController();
    Alert(
        context: context,
        title: "Add New Task",
        content: Container(
          padding: EdgeInsets.only(top: 16),
          child: TextField(
            controller: textEditingController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Task Name..',
              hintText: "Enter Your Task Name Here",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (textEditingController.text != null &&
                  textEditingController.text.trim().isNotEmpty) {
                Navigator.pop(context);
                addNewTask(textEditingController.text.trim());
                textEditingController.clear();
              }
            },
            child: Text(
              "Add",
              style: TextStyle(fontSize: 18),
            ),
            radius: BorderRadius.circular(8),
          ),
        ],
        style: AlertStyle(
          animationType: AnimationType.grow,
          buttonAreaPadding: EdgeInsets.all(8),
          alertBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          animationDuration: Duration(milliseconds: 400),
          isCloseButton: false,
        )).show();
  }

  addNewTask(String name) async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        progressWidget: Center(child: CircularProgressIndicator()),
        message: 'Loading...',
        borderRadius: 8);
    pr.show();
    await taskBloc.addTask(widget.category,
        new Task(title: name, description: name, isDone: false));
    pr.dismiss();
  }

  body() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: buildTasksList(),
        ),
        SolidBottomSheet(
          headerBar: null,
          body: panel(),
          maxHeight: 175,
          controller: solidController,
          smoothness: Smoothness.high,
        ),
      ],
    );
  }

  panel() {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        shrinkWrap: true,
        children: List.generate(
          MyColors.categoryColors.length,
          (index) {
            return Container(
              child: IconButton(
                icon: Icon(
                  Icons.fiber_manual_record,
                  size: 32,
                  color: MyColors.categoryColors[index].color,
                ),
                onPressed: () {
                  print("${MyColors.categoryColors[index].name}");
                  setState(() {
                    solidController.hide();
                    widget.category.color = MyColors.categoryColors[index].name;
                    categoryBloc.editColor(widget.category);
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}