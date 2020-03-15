import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/category_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  SolidController solidController = new SolidController();

  List<CategoryModel> categories = new List();

  Stream<QuerySnapshot> categoriesStream;

  @override
  void initState() {
    super.initState();
    categoriesStream = Firestore.instance
        .collection('users')
        .document(AppCache()
        .getFirebaseUser()
        .uid)
        .collection('categories')
        .orderBy('time', descending: true)
        .snapshots();

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 400),
      reverseDuration: new Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
//    categories.add(new Category(name: "Name", tasks: new List()));
    return Scaffold(
      bottomSheet: bottomSheet(),
      appBar: AppBar(
        elevation: Constants.elevation,
        title: new Text("Todo App"),
      ),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: IconButton(
                  icon: Icon(Icons.check_circle), onPressed: () {}),
            ),
            Expanded(
              child: Divider(color: Colors.transparent),
            ),
            Expanded(
              child: IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (solidController.isOpened) {
            animationController.reverse();
            solidController.hide();
          } else {
            animationController.forward();
            solidController.show();
          }
        },
        child: RotationTransition(
          child: Icon(Icons.add),
          turns: Tween(begin: 0.0, end: -0.125).animate(animationController),
        ),
      ),
      body: body(),
    );
  }

  addNewCategory(String name) async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        progressWidget: Center(child: CircularProgressIndicator()),
        message: 'Loading...',
        borderRadius: 8);
    pr.show();
//    await categoryBloc.addCategory(new Category(name: name, tasks: new List()));
    pr.dismiss();
  }

  bottomSheet() {
    return SolidBottomSheet(
      toggleVisibilityOnTap: false,
      headerBar: null,
      body: panel(),
      maxHeight: 175,
      controller: solidController,
      smoothness: Smoothness.low,
    );
  }

  panel() {
    TextEditingController textEditingController = new TextEditingController();
    return Container(
      padding: EdgeInsets.only(top: 25),
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: textEditingController,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: "Name your category",
              border: InputBorder.none,
            ),
          ),
          OutlineButton(
            padding: EdgeInsets.all(8),
            child: Text(
              "Add Category",
              style: TextStyle(fontSize: 16),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onPressed: () {
              if (textEditingController.text != null &&
                  textEditingController.text.trim().isNotEmpty) {
                animationController.reverse();
                solidController.hide();
                addNewCategory(textEditingController.text.trim());
                textEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  body() {
    return StreamBuilder(
      stream: categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData)
          return snapshot.data.documents.length == 0
              ? Center(
            child: Text(
              'Add your first category...',
              style: TextStyle(fontSize: 24),
            ),
          )
              : ListView.builder(
            padding: EdgeInsetsDirectional.only(
                top: 8, start: 8, end: 8, bottom: 72),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
//                    return new CategoryWidget(
//                        category: new Category.firebase(
//                            snapshot.data.documents[index]));
                    return Container();
                  },
                );
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
