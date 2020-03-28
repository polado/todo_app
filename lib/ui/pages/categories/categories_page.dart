import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category_model.dart';
import 'package:todo_app/ui/pages/categories/add_edit_category/add_edit_category_page.dart';
import 'package:todo_app/ui/widgets/category_widget.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends BaseState<CategoriesPage> {
  List<CategoryModel> _categories;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(AppCache()
              .getFirebaseUser()
              .uid)
              .collection('categories')
              .orderBy('time', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              _categories = CategoryModel.fromList(snapshot.data);
              AppCache().setCategories(_categories);
              return Container(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 96),
                  children: _categories.map((c) {
                    return CategoryWidget(
                      category: c,
                      callback: () =>
                          navigateTo(
                              AddEditCategoryPage(isEdit: true, category: c)),
                    );
                  }).toList(),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
