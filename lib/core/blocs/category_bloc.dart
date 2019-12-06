import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category.dart';

class CategoryBloc {
  addCategory(Category category) async {
    Timestamp time = Timestamp.now();
    await Firestore.instance
        .collection('users')
        .document(AppCache.firebaseUser.uid)
        .collection('categories')
        .document()
        .setData({
      'time': time,
      'name': category.name,
//      'color': category.color,
    });
    return true;
  }

  editColor(Category category) async {
    await Firestore.instance
        .collection('users')
        .document(AppCache.firebaseUser.uid)
        .collection('categories')
        .document(category.id)
        .updateData({'color': category.color});
  }
}

final categoryBloc = new CategoryBloc();
