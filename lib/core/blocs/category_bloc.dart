import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category_model.dart';

class CategoryBloc {
  addCategory(CategoryModel category) async {
    Timestamp time = Timestamp.now();
    await Firestore.instance
        .collection('users')
        .document(AppCache.instance
        .getUser()
        .uid)
        .collection('categories')
        .document()
        .setData({
      'time': time,
      'name': category.name,
//      'color': category.color,
    });
    return true;
  }

  editColor(CategoryModel category) async {
    await Firestore.instance
        .collection('users')
        .document(AppCache.instance
        .getUser()
        .uid)
        .collection('categories')
        .document(category.id)
        .updateData({'color': category.color});
  }
}

final categoryBloc = new CategoryBloc();
