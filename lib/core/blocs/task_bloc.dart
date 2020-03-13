import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category_model.dart';
import 'package:todo_app/core/models/task_model.dart';

class TaskBloc {
  addTask(TaskModel task) async {
    Timestamp time = Timestamp.now();
    await Firestore.instance
        .collection('users')
        .document(AppCache.instance
        .getUser()
        .uid)
        .collection('tasks')
        .document()
        .setData({
      'time': time,
      'title': task.title,
      'description': task.description,
      'due_date': task.dueDate,
      'is_done': task.isDone,
      'category': task.category.toJson()
    });
    return true;
  }

  toggleTaskIsDone(CategoryModel category, TaskModel task) async {
    await Firestore.instance
        .collection('users')
        .document(AppCache.instance
        .getUser()
        .uid)
        .collection('tasks')
        .document(task.id)
        .updateData({
      'is_done': task.isDone,
    });
  }
}

final taskBloc = new TaskBloc();
