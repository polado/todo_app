import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/user_model.dart';
import 'package:todo_app/ui/pages/categories/add_edit_category/add_edit_category_page.dart';
import 'package:todo_app/ui/pages/categories/categories_page.dart';
import 'package:todo_app/ui/pages/profile/profile_page.dart';
import 'package:todo_app/ui/pages/tasks/add_edit_task/add_edit_task_page.dart';
import 'package:todo_app/ui/pages/tasks/tasks_page.dart';

class HostPage extends StatefulWidget {
  @override
  _HostPageState createState() => _HostPageState();
}

class _HostPageState extends BaseState<HostPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(_index == 0 ? "Categories" : "Tasks"),
        actions: <Widget>[
          SizedBox(width: 8),
          Container(
            child: FloatingActionButton(
              onPressed: () => navigateTo(ProfilePage()),
              heroTag: "profile",
              mini: true,
              elevation: 0,
              highlightElevation: 0,
              clipBehavior: Clip.antiAlias,
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document(AppCache()
                    .getFirebaseUser()
                    .uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = UserModel(snapshot.data);
                    return Image.network(user.photoUrl, fit: BoxFit.cover);
                  } else
                    return Image.asset('assets/images/placeholder.jpg');
                },
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedSwitcher(
        switchInCurve: Curves.easeInExpo,
        switchOutCurve: Curves.easeOutExpo,
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 500),
        child: _index == 0
            ? FloatingActionButton(
            heroTag: "category",
            onPressed: () => navigateTo(AddEditCategoryPage(isEdit: false)),
            backgroundColor: Theme
                .of(context)
                .buttonColor,
            child: Icon(Icons.add))
            : FloatingActionButton(
            heroTag: "task",
            onPressed: () => navigateTo(AddEditTaskPage(isEdit: false)),
            backgroundColor: Theme
                .of(context)
                .accentColor,
            child: Icon(Icons.add)),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.cyan,
          selectedFontSize: 12,
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _tabController.animateTo(index);
              _index = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), title: Text("Categories")),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), title: Text("Tasks")),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          CategoriesPage(),
          TasksPage(),
        ],
      ),
    );
  }

  _signOut() async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
  }
}
