import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as datepicker;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/core/blocs/task_bloc.dart';
import 'package:todo_app/core/models/category.dart';
import 'package:todo_app/core/models/task.dart';

class AddTaskPage extends StatefulWidget {
  final Category category;

  const AddTaskPage({Key key, this.category}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerDescription = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: MyColors.getColor(widget.category.color),
      appBar: new AppBar(
        title: Text("Add New Task"),
        backgroundColor: MyColors.getColor(widget.category.color),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                if (controllerName.text != null &&
                    controllerName.text.trim().isNotEmpty) {
                  if (controllerDescription.text == null)
                    controllerDescription.text = '';

                  ProgressDialog pr = new ProgressDialog(context,
                      type: ProgressDialogType.Normal,
                      isDismissible: false,
                      showLogs: false);
                  pr.style(
                      progressWidget:
                          Center(child: CircularProgressIndicator()),
                      message: 'Loading...',
                      borderRadius: 8);
                  pr.show();
                  await taskBloc.addTask(
                      widget.category,
                      new Task(
                          title: controllerName.text.trim(),
                          description: controllerDescription.text.trim(),
                          dueDate: Timestamp.fromDate(selectedDate),
                          addedDate: Timestamp.now(),
                          isDone: false));
                  pr.dismiss();
                  Navigator.pop(context);
                }
              })
        ],
      ),
      body: body(),
    );
  }

  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(new Duration(days: 1));

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
}
