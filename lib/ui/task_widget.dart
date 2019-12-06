import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/blocs/task_bloc.dart';
import 'package:todo_app/core/models/category.dart';
import 'package:todo_app/core/models/task.dart';

class TaskWidget extends StatefulWidget {
  final Category category;
  final Task task;

  const TaskWidget({Key key, this.task, this.category}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularCheckBox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Theme.of(context).accentColor,
            value: widget.task.isDone,
            onChanged: (bool value) {
              widget.task.isDone = value;
              taskBloc.toggleTaskIsDone(widget.category, widget.task);
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            '${widget.task.title}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                decoration: widget.task.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            '${new DateFormat('dd/MM/yy').format(widget.task.dueDate.toDate())}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:  FontWeight.bold,
                                color: widget.task.dueDate
                                        .toDate()
                                        .isAfter(DateTime.now())
                                    ? Colors.black
                                    : Colors.red,
                                decoration: widget.task.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${widget.task.description}',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: widget.task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
