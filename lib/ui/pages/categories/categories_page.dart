import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/core/models/category_model.dart';
import 'package:todo_app/ui/widgets/yudiz_modal_sheet.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends BaseState<CategoriesPage> {
  var _categories = [
    new CategoryModel('Small', Colors.green),
    new CategoryModel('Small', Colors.blue),
    new CategoryModel('Medium', Colors.indigo),
    new CategoryModel('Large', Colors.deepOrange),
    new CategoryModel('Large', Colors.orange),
    new CategoryModel('Large', Colors.pink),
    new CategoryModel('XLarge', Colors.purple),
    new CategoryModel('XLarge', Colors.deepPurple),
    new CategoryModel('XLarge', Colors.deepPurple),
    new CategoryModel('XLarge', Colors.deepPurple),
    new CategoryModel('XLarge', Colors.deepPurple),
    new CategoryModel('XLarge', Colors.deepPurple),
    new CategoryModel('XLarge', Colors.deepPurple),
    new CategoryModel('XLarge', Colors.deepPurple),
  ];

  bool _showFab = true;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nameController = new TextEditingController();

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Categories"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: _showFab
          ? FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                YudizModalSheet.show(
                    context: context,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 24, left: 16, right: 16, bottom: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(16),
                              topEnd: Radius.circular(16))),
                      child: new Wrap(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text("Enter Category Name",
                                style: TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Theme(
                              data: ThemeData(primaryColor: Colors.cyan),
                              child: TextField(
                                controller: _nameController,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.description, size: 21),
                                  border: InputBorder.none,
                                  hintText: "Category Name",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    direction: YudizModalSheetDirection.BOTTOM);
              },
              backgroundColor: Theme.of(context).buttonColor,
              mini: true,
              child: Icon(
                Icons.library_add,
                size: 18,
                color: Colors.white,
              ),
            )
          : Container(),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 16, bottom: 96),
          children: _categories.map((c) {
            return Card(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.only(top: 12, left: 16, right: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
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
            );
          }).toList(),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    YudizModalSheet.show(
        context: context,
        child: Container(
          color: Colors.white,
          height: 250,
          child: Center(
            child: Text("Hello from top"),
          ),
        ),
        direction: YudizModalSheetDirection.TOP);
  }
}
