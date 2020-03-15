import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category_model.dart';
import 'package:todo_app/core/models/user.dart';
import 'package:todo_app/ui/pages/categories/add_edit_category/add_edit_category_page.dart';

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
      appBar: AppBar(
        title: Text("Categories"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        heroTag: "btn2",
        onPressed: () => navigateTo(AddEditCategoryPage(isEdit: false)),
        backgroundColor: Theme
            .of(context)
            .buttonColor,
        mini: true,
        child: Icon(
          Icons.library_add,
          size: 18,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(AppCache()
              .getFirebaseUser()
              .uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              AppCache().setUser(new UserModel(snapshot.data));
              _categories = AppCache()
                  .getUser()
                  .categories;

              return Container(
                child: ListView(
                  padding: EdgeInsets.only(top: 16, bottom: 96),
                  children: _categories.map((c) {
                    return Card(
                      elevation: 1,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.only(top: 12, left: 16, right: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      child: InkWell(
                        onTap: () {
                          navigateTo(
                              AddEditCategoryPage(isEdit: true, category: c,));
                        },
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 8),
                              Expanded(child: Text(c.name)),
                              IconButton(
                                  icon: Icon(
                                    Icons.brightness_1,
                                    color: c.color,
                                  ),
                                  onPressed: null)
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

//  void _showAddCategory(CategoryModel category) {
//    YudizModalSheet.show(
//      context: context,
//      direction: YudizModalSheetDirection.BOTTOM,
//      child: Container(
//        padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
//        decoration: BoxDecoration(
//            color: Colors.white,
//            borderRadius: BorderRadiusDirectional.only(
//                topStart: Radius.circular(16), topEnd: Radius.circular(16))),
//        child: new Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            SizedBox(height: 8),
//            Text(category == null ? "Add new category" : "Edit category",
//                style: TextStyle(fontSize: 16)),
//            SizedBox(height: 16),
//            Row(
//              children: <Widget>[
//                IconButton(icon: Icon(Icons.description), onPressed: null),
//                Expanded(
//                  child: TextField(
//                    controller: _nameController,
//                    textCapitalization: TextCapitalization.sentences,
//                    style: TextStyle(fontSize: 14),
//                    decoration: InputDecoration(
////                      prefixIcon: Icon(Icons.description, size: 21),
//                      border: InputBorder.none,
//                      hintText: "Category Name",
//                    ),
//                  ),
//                ),
//              ],
//            ),
//            Divider(),
//            Row(
//              children: <Widget>[
//                IconButton(icon: Icon(Icons.color_lens), onPressed: null),
//                Expanded(child: Text("Color", style: TextStyle(fontSize: 14))),
//                IconButton(
//                    icon: Icon(Icons.check_circle, color: _color, size: 28),
//                    onPressed: () async {
//                      var color = await _showColorPicker();
//                      if (color != null)
//                        setState(() {
//                          _color = color;
//                        });
//                    }),
//              ],
//            ),
//            Divider(),
//            SizedBox(height: 16),
//            FlatButtonWidget(
//              text: "Add",
//              callback: () {
//                Navigator.of(context).pop();
//                _addCategory();
//              },
//            )
//          ],
//        ),
//      ),
//    );
//  }
}
