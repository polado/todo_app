import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as datepicker;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/core/blocs/task_bloc.dart';
import 'package:todo_app/core/models/category.dart';
import 'package:todo_app/core/models/task.dart';

class AddEditTaskPage extends StatefulWidget {
  final Category category;
  final Task task;

  const AddEditTaskPage({Key key, this.category, this.task}) : super(key: key);

  @override
  _AddEditTaskPageState createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerDescription = new TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(new Duration(days: 1));

  String title;

  @override
  void initState() {
    if (widget.task == null) {
      title = 'Add New Task';
    } else {
      title = 'Edit Task';
      controllerName.text = widget.task.title;
      controllerDescription.text = widget.task.description;
      selectedDate = widget.task.dueDate.toDate();
      if (DateTime.now().isAfter(widget.task.dueDate.toDate()))
        startDate =
            widget.task.dueDate.toDate().subtract(new Duration(days: 1));
      else
        startDate = DateTime.now().subtract(new Duration(days: 1));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: MyColors.getColor(widget.category.color),
      appBar: new AppBar(
        title: Text(title),
        backgroundColor: MyColors.getColor(widget.category.color),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: () => submit())
        ],
      ),
      body: body(),
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: controllerName,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 18,
              ),
              border: InputBorder.none,
              hintText: "What would you like to do?",
            ),
          ),
          Divider(),
          TextField(
            minLines: 3,
            maxLines: 5,
            controller: controllerDescription,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 16,
              ),
              border: InputBorder.none,
              hintText: "Description?",
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Due Date",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: MyColors.getColor(widget.category.color)),
            ),
          ),
          Expanded(
            child: datepicker.DayPicker(
              selectedDate: selectedDate,
              onChanged: (value) {
                setState(() {
                  if (value.isAfter(startDate)) selectedDate = value;
                });
              },
              firstDate: startDate,
              lastDate: DateTime(2030),
              datePickerLayoutSettings:
                  datepicker.DatePickerLayoutSettings(maxDayPickerRowCount: 2),
            ),
          ),
        ],
      ),
    );
  }

  submit() async {
    if (controllerName.text != null && controllerName.text
        .trim()
        .isNotEmpty) {
      if (controllerDescription.text == null) controllerDescription.text = '';

      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: false,
          showLogs: false);
      pr.style(
          progressWidget: Center(child: CircularProgressIndicator()),
          message: 'Loading...',
          borderRadius: 8);
      pr.show();

      Task task;
      bool isEdit;
      if (widget.task == null) {
        isEdit = false;
        task = new Task(
            title: controllerName.text.trim(),
            description: controllerDescription.text.trim(),
            dueDate: Timestamp.fromDate(selectedDate),
            addedDate: Timestamp.now(),
            isDone: false);
      } else {
        isEdit = true;
        task = new Task.edit(
            id: widget.task.id,
            title: controllerName.text.trim(),
            description: controllerDescription.text.trim(),
            dueDate: Timestamp.fromDate(selectedDate),
            addedDate: widget.task.addedDate,
            isDone: widget.task.isDone);
      }

      bool res = await taskBloc.addEditTask(widget.category, task, isEdit);
      print('back');
      pr.dismiss();
//      if (pr.isShowing()) {
//        print('showing');
//
//        Navigator.pop(context);
//      }
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
