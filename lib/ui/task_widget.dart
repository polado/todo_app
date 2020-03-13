import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/blocs/task_bloc.dart';
import 'package:todo_app/core/models/category_model.dart';
import 'package:todo_app/core/models/task_model.dart';

class TaskWidget extends StatefulWidget {
  final CategoryModel category;
  final TaskModel task;

  const TaskWidget({Key key, this.task, this.category}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.category.color,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 12, left: 16, right: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        color: Colors.white,
        margin: EdgeInsetsDirectional.only(end: 4),
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: widget.task.category.color,
                value: widget.task.isDone,
                onChanged: (bool value) {
                  widget.task.isDone = value;
                  taskBloc.toggleTaskIsDone(widget.category, widget.task);
                },
              ),
            ),
            Card(
              color: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  '${new DateFormat('MMM dd yyyy').format(
                      widget.task.dueDate.toDate())}',
                  style: TextStyle(
                      fontSize: 12,
                      color: widget.task.dueDate
                          .toDate()
                          .isAfter(DateTime.now())
                          ? Colors.grey
                          : Colors.red,
                      decoration: widget.task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Text(
                  '${widget.task.title}',
                  style: TextStyle(
                      fontSize: 16,
                      decoration: widget.task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
