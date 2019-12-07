import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category.dart';

class CategoryBloc {
  addEditCategory(Category category, bool isEdit) async {
    Timestamp time = Timestamp.now();
    if (isEdit)
      await Firestore.instance
          .collection('users')
          .document(AppCache.firebaseUser.uid)
          .collection('categories')
          .document(category.id)
          .updateData({
        'name': category.name,
      });
    else
      await Firestore.instance
          .collection('users')
          .document(AppCache.firebaseUser.uid)
          .collection('categories')
          .document()
          .setData({
        'time': time,
        'name': category.name,
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

  deleteCategory(Category category) async {
    await Firestore.instance
        .collection('users')
        .document(AppCache.firebaseUser.uid)
        .collection('categories')
        .document(category.id)
        .delete();
  }
}

final categoryBloc = new CategoryBloc();
