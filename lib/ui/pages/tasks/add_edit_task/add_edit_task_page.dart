import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as datePicker;
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/blocs/task_bloc.dart';
import 'package:todo_app/core/models/category_model.dart';
import 'package:todo_app/core/models/task_model.dart';

class AddEditTaskPage extends StatefulWidget {
  final TaskModel task;
  final CategoryModel category;
  final bool isEdit;

  const AddEditTaskPage({Key key, this.task, this.isEdit, this.category})
      : super(key: key);

  @override
  _AddEditTaskPageState createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends BaseState<AddEditTaskPage> {
  List<CategoryModel> _categories = new List();
  int _value = 0;

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(new Duration(days: 1));

  @override
  void initState() {
    _categories = AppCache().getCategories();
    super.initState();
    if (widget.isEdit) {
      _titleController.text = widget.task.title;
      if (widget.task.description != null && widget.task.description.isNotEmpty)
        _descController.text = widget.task.description;

      selectedDate = new DateTime.fromMillisecondsSinceEpoch(
          widget.task.dueDate.millisecondsSinceEpoch);

      _value = CategoryModel.getIndex(_categories, widget.category);
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Task"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: _addTask),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: _categories.map((c) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Row(
                          children: <Widget>[
                            Icon(
                              Icons.brightness_1,
                              color: c.color,
                              size: 12,
                            ),
                            SizedBox(width: 8),
                            Text(c.name),
                          ],
                        ),
                        pressElevation: Constants.elevation,
                        elevation: Constants.elevation,
                        selected: _value == _categories.indexOf(c),
                        selectedColor: Theme.of(context).accentColor,
                        onSelected: (bool value) => setState(() {
                          return _value = _categories.indexOf(c);
                        }),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What would you like to do?",
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                minLines: 3,
                maxLines: 5,
                controller: _descController,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 16),
                  border: InputBorder.none,
                  hintText: "Description?",
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                "Due Date",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 21,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: datePicker.DayPicker(
                selectedDate: selectedDate,
                datePickerStyles: datePicker.DatePickerRangeStyles(
                  currentDateStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).buttonColor),
                  selectedSingleDateDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).accentColor),
                ),
                onChanged: (value) => setState(() {
                  if (value.isAfter(startDate)) selectedDate = value;
                }),
                firstDate: startDate,
                lastDate: DateTime(2030),
                datePickerLayoutSettings: datePicker.DatePickerLayoutSettings(
                    maxDayPickerRowCount: 5),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  bool _validate() {
    if (_titleController.text.isEmpty) {
      showErrorMsg("Enter Your Task");
      return false;
    } else if (_descController.text.isEmpty) _descController.text = "";
    return true;
  }

  void _addTask() async {
    if (_validate()) {
      showLoading();
      await taskBloc.addTask(
          _categories[_value],
          new TaskModel(
            title: _titleController.text.trim(),
            description: _descController.text.trim(),
            dueDate: Timestamp.fromDate(selectedDate),
            addedDate: Timestamp.now(),
            category: _categories[_value],
            isDone: false,
          ));
      hideLoading();
      Navigator.of(context).pop();
    }
  }
}
