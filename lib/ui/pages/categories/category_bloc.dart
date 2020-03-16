import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/base/base_bloc.dart';
import 'package:todo_app/base/base_view.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category_model.dart';

class CategoriesBloc extends BaseBloc {
  StreamController<Color> colorController = StreamController();

  CategoriesBloc(BaseView view) : super(view);

  addCategory(CategoryModel category) async {
    Timestamp time = Timestamp.now();
    await Firestore.instance
        .collection('users')
        .document(AppCache()
        .getFirebaseUser()
        .uid)
        .collection('categories')
        .document()
        .setData({
      "time": time,
      "name": category.name,
      "color": category.color.value
    });
    return true;
  }

  editCategory(CategoryModel oldCategory, CategoryModel category) async {
    print("edit category");
    await Firestore.instance
        .collection('users')
        .document(AppCache()
        .getFirebaseUser()
        .uid)
        .collection('categories')
        .document(oldCategory.id)
        .updateData({"name": oldCategory.name, "color": category.color.value});
    return true;
  }

  @override
  void onDispose() {
    colorController.close();
  }
}
