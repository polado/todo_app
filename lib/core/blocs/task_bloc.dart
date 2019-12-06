import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category.dart';
import 'package:todo_app/core/models/task.dart';

class TaskBloc {
  addTask(Category category, Task task) async {
    Timestamp time = Timestamp.now();
    await Firestore.instance
        .collection('users')
        .document(AppCache.firebaseUser.uid)
        .collection('categories')
        .document(category.id)
        .collection('tasks')
        .document()
        .setData({
      'time': time,
      'title': task.title,
      'description': task.description,
      'due_date': task.dueDate,
      'is_done': task.isDone,
    });
    return true;
  }

  toggleTaskIsDone(Category category, Task task) async {
    await Firestore.instance
        .collection('users')
        .document(AppCache.firebaseUser.uid)
        .collection('categories')
        .document(category.id)
        .collection('tasks')
        .document(task.id)
        .updateData({
      'is_done': task.isDone,
    });
  }
}

final taskBloc = new TaskBloc();
