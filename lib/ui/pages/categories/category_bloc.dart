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
    await Firestore.instance
        .collection('users')
        .document(AppCache()
        .getFirebaseUser()
        .uid)
        .updateData({
      'categories': FieldValue.arrayUnion([
        {'name': category.name, 'color': category.color.value}
      ])
    });
    return true;
  }

  editCategory(CategoryModel oldCategory, CategoryModel category) async {
    await Firestore.instance
        .collection('users')
        .document(AppCache()
        .getFirebaseUser()
        .uid)
        .updateData({
      'categories': FieldValue.arrayRemove([
        {'name': oldCategory.name, 'color': oldCategory.color.value}
      ])
    });
    return addCategory(category);
  }

  editColor(CategoryModel category) async {
    await Firestore.instance
        .collection('users')
        .document(AppCache()
        .getFirebaseUser()
        .uid)
        .collection('categories')
        .document(category.id)
        .updateData({'color': category.color});
  }

  @override
  void onDispose() {
    colorController.close();
  }
}
