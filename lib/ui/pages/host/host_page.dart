import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/ui/pages/add_task/add_task_page.dart';
import 'package:todo_app/ui/pages/categories/categories_page.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(AddTaskPage());
        },
        child: Icon(Icons.add),
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
                icon: Icon(Icons.dashboard), title: Text("Tasks")),
//            BottomNavigationBarItem(icon: Container(), title: Container()),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), title: Text("Categories")),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          TasksPage(),
//          Container(),
          CategoriesPage(),
        ],
      ),
    );
  }
}
